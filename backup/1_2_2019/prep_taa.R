setproj(10)

#Load lookups
load(paste(gdrivepath,"research/data/lookup/USA lookups.RData",sep=""))
load(paste(gdrivepath,"research/data/cntyfacts/pop.RData",sep=""))

#Read in data
path = "research/proj_010_trump/data/raw/Public Citizen TAA Data 2018.csv"
types = c("character","character","character","character","character","character",
          "character","character","character","integer","character","character")
varnames = c("company","city","stateabr","district","cntynameorig","metro","product","petitioner",
             "layoffdate","nworkers","cause","country")
data = data.table(read.csv(paste(gdrivepath,path,sep=""), header=TRUE, colClasses=types, col.names=varnames))
# Clean up county name to prepare for merge with lookup
cntymatch = data$cntynameorig
cntymatch = gsub(" County","",cntymatch)
cntymatch = gsub(" Parish","",cntymatch)
cntymatch = gsub(" and Borough","",cntymatch)
cntymatch = gsub(" Borough","",cntymatch)
cntymatch = gsub(" Municipality","",cntymatch)
cntymatch = gsub(" Census Area","",cntymatch)
cntymatch = gsub("[[:punct:]]", "", cntymatch)
cntymatch = gsub(" ", "", cntymatch)
cntymatch = tolower(cntymatch)
data = cbind(data,cntymatch)

# Merge with lookup
data = merge(data,cnty.lookup,by=c("cntymatch","stateabr"),X.all=TRUE)

# Sum across all time
sincebeg = data[,.(taa.wrks.beg=sum(nworkers),taa.reqs.beg=.N),by=.(statefipsn,cntyfipsn)]
# get layoff date
data[,date:=mdy(layoffdate)]
data[,year:=year(date)]
# Sum within year
data = data[,.(taa.wrks=sum(nworkers),taa.reqs=.N),by=.(statefipsn,cntyfipsn,year)]
maxyear = max(data$year,na.rm=TRUE)
minyear = min(data$year,na.rm=TRUE)
years = seq(minyear,maxyear,1)
xt = CJ(years,cnty.lookup$fipsn)
setnames(xt,c('V1','V2'),c('year','fipsn'))
taa = merge(xt,cnty.lookup[,.(statefipsn,cntyfipsn,fipsn)],all.x=T,by='fipsn')
taa = merge(taa,data,all.x=T,by=c('statefipsn','cntyfipsn','year'))




taawithpop = merge(taa,cntyfacts.pop,all=T,by=c('statefipsn','cntyfipsn','year'))
taawithpop = taawithpop[year<2017]
# Create county level sums
taacnty = taawithpop[,0,by=c('statefipsn','cntyfipsn')][,1:2]
# Sort recent years to top, for discsum function
taawithpop = taawithpop[order(statefipsn,cntyfipsn,-year)]
# Merge in population
discsum = function(x,rho) {
   rho.n = rep(rho,length(x))
   power.n = seq(0,length(x)-1,1)
   discfac = rho.n^power.n
   discsum = sum(x*discfac,na.rm=T)
   return(discsum)
}
# Main Loop
varlist = c('taa.wrks','taa.reqs','pop')
for (var in varlist) {
   varname = paste(var,'.12',sep='')
   t=taawithpop[year>=2012, sum(get(var),na.rm=T),by=c('statefipsn','cntyfipsn')]
   setnames(t,'V1',varname)
   taacnty=merge(taacnty,t)
   
   varname = paste(var,'.8',sep='')
   t=taawithpop[year>=2008, sum(get(var),na.rm=T),by=c('statefipsn','cntyfipsn')]
   setnames(t,'V1',varname)
   taacnty=merge(taacnty,t)
   
   varname = paste(var,'.disc95',sep='')
   t=taawithpop[, discsum(get(var),.95),by=c('statefipsn','cntyfipsn')]
   setnames(t,'V1',varname)
   taacnty=merge(taacnty,t)
}

varlist = c('taa.wrks','taa.reqs')
suffixlist = c('.12','.8','.disc95')
for (var in varlist) {
   for (suffix in suffixlist) {
      taacnty[, paste(var,suffix,'.pcpy',sep=''):= get(paste(var,suffix,sep=''))/get(paste('pop',suffix,sep=''))]
   }
}

sincebegpcpy = as.data.table(taawithpop %>% group_by(statefipsn,cntyfipsn) %>% summarize_at(vars(-statefipsn,-cntyfipsn,-fipsn,-year), mean, na.rm=T))
gen.pc(sincebegpcpy,c('taa.wrks','taa.reqs'),'pop','.beg.pcpy')

taacnty = merge(taacnty,sincebeg,all=T,by=c('statefipsn','cntyfipsn'))
taacnty = merge(taacnty,sincebegpcpy[,.(statefipsn,cntyfipsn,taa.wrks.beg.pcpy,taa.reqs.beg.pcpy)],all=T,by=c('statefipsn','cntyfipsn'))


taacnty = select(taacnty,-contains('pop'))
# Save data
save(taa, taacnty, file = paste(datpath,"taa.Rdata",sep=""))

# Graph it
# require(choroplethr)
# require(choroplethrMaps)
# plotdata = data.table(region=as.numeric(taaCnty$fips),value=taaCnty$nworkers)
# county_choropleth(plotdata)