load(paste(gdrivepath,"research/data/lookup/USA lookups.RData",sep=""))

#Read in MCHS data
setwd(rawpath)
t.in = fread(file='NCHS_-_Drug_Poisoning_Mortality_by_County__United_States.csv',
             colClasses=c('character','integer','character','integer','character','character','character'),
             col.names=c('fipsstr','year','statename','statefipsn','cntynameproper','pop','mort.drugalc'))

t.in[,cntyfipsn := as.integer(substr(fipsstr,nchar(fipsstr)-2,nchar(fipsstr)))]
t.in[,pop:=as.integer(gsub(",", "", pop))]
t.in[mort.drugalc == '<2',mort.drugalc:='0-2']
t.in[,mort.drugalc.lo := as.numeric(substr(mort.drugalc,1,regexpr('-',mort.drugalc)-1))] 
t.in[,mort.drugalc.hi := as.numeric(substr(mort.drugalc,regexpr('-',mort.drugalc)+1,nchar(mort.drugalc)))] 
t.in[mort.drugalc=='30+', `:=`(mort.drugalc.lo=0,mort.drugalc.hi=Inf)]
t.in=t.in[,.(year,statefipsn,cntyfipsn,pop,mort.drugalc.lo,mort.drugalc.hi)]
mchs.mort.drugalc = t.in
setwd(datpath)
save(mchs.mort.drugalc,file='mchs_mort_drugalc.Rdata')

# Read in Opioid Data
setwd(rawpath)
t.in.nonopioid = fread(file='ucd nonopioid allyrs.txt',
             colClasses=c('character','character','character','integer','integer','character','integer','character'),
             col.names=c('notes','countynameproper','fipsstr','year','yearcode','mort.nonopioid','pop','mort.nonopioid.rate')
)
t.in.nonopioid[,`:=`(mort.nonopioid=as.integer(mort.nonopioid),mort.nonopioid.rate=as.numeric(mort.nonopioid.rate))]
t.in.withopioid = fread(file='ucd withopioid allyrs.txt',
             colClasses=c('character','integer','integer','character','character','character','character','character'),
             col.names=c('notes','year','yearcode','countynameproper','fipsstr','mort.withopioid','pop','mort.withopioid.rate')
)
t.in.withopioid[,`:=`(mort.withopioid=as.integer(mort.withopioid),mort.withopioid.rate=as.numeric(mort.withopioid.rate))]

cdc.mort.opioid = merge(t.in.nonopioid[,.(fipsstr,year,mort.nonopioid,pop,mort.nonopioid.rate)],
                         t.in.withopioid[,.(fipsstr,year,mort.withopioid,mort.withopioid.rate)],
                         by=c('fipsstr','year'))
cdc.mort.opioid[, `:=` (mort.ucd.opioid = as.numeric(mort.withopioid)-as.numeric(mort.nonopioid),
                         mort.ucd.opioid.rate = as.numeric(mort.withopioid.rate)-as.numeric(mort.nonopioid.rate))]

#cdc.mort.suicide = merge(cdc.mort.suicide,cnty.lookup,by='fipsstr')
cdc.mort.opioid = cdc.mort.opioid[,.(fipsstr,year,mort.ucd.opioid,mort.ucd.opioid.rate)]

# Read in WONDER drug/alc data
setwd(rawpath)
t.1 = c('ucd all deaths','ucd non drugalc deaths')
t.2 = c('post 2009','pre 2009')
t.3 = c('',' adj')
t.4 = data.table(expand.grid(t.1,t.2,t.3),stringsAsFactors = F)
t.4[,filename := paste(Var1,' ',Var2,Var3,'.txt',sep='')]

# Crude Data
t.in.1=fread(file=t.4$filename[1],
           select=c('County Code','Year','Deaths','Crude Rate'),
           colClasses=c(`County Code`='character',`Year`='integer',`Deaths`='integer',`Crude Rate`='character'),
           col.names=c(`County Code`='fipsstr',`Year`='year',`Deaths`='mort.ucd.all',`Crude Rate`='mort.ucd.all.ratecrude')
)
t.in.1[,`:=` (mort.ucd.all.ratecrude = as.numeric(mort.ucd.all.ratecrude),mort.ucd.all=as.numeric(mort.ucd.all))]
t.in.2=fread(file=t.4$filename[2],
           select=c('County Code','Year','Deaths','Crude Rate'),
           colClasses=c(`County Code`='character',`Year`='integer',`Deaths`='character',`Crude Rate`='character'),
           col.names=c(`County Code`='fipsstr',`Year`='year',`Deaths`='mort.ucd.nondrugalc',`Crude Rate`='mort.ucd.nondrugalc.ratecrude')
)
t.in.2[,`:=` (mort.ucd.nondrugalc.ratecrude = as.numeric(mort.ucd.nondrugalc.ratecrude),mort.ucd.nondrugalc=as.numeric(mort.ucd.nondrugalc))]
t.in.3= merge(t.in.1,t.in.2,by=c('fipsstr','year'))

t.in.1=fread(file=t.4$filename[3],
             select=c('County Code','Year','Deaths','Crude Rate'),
             colClasses=c(`County Code`='character',`Year`='integer',`Deaths`='integer',`Crude Rate`='character'),
             col.names=c(`County Code`='fipsstr',`Year`='year',`Deaths`='mort.ucd.all',`Crude Rate`='mort.ucd.all.ratecrude')
)

t.in.1[,`:=` (mort.ucd.all.ratecrude = as.numeric(mort.ucd.all.ratecrude),mort.ucd.all=as.numeric(mort.ucd.all))]
t.in.2=fread(file=t.4$filename[4],
             select=c('County Code','Year','Deaths','Crude Rate'),
             colClasses=c(`County Code`='character',`Year`='integer',`Deaths`='character',`Crude Rate`='character'),
             col.names=c(`County Code`='fipsstr',`Year`='year',`Deaths`='mort.ucd.nondrugalc',`Crude Rate`='mort.ucd.nondrugalc.ratecrude')
)

t.in.2[,`:=` (mort.ucd.nondrugalc.ratecrude = as.numeric(mort.ucd.nondrugalc.ratecrude),mort.ucd.nondrugalc=as.numeric(mort.ucd.nondrugalc))]
t.in.4= merge(t.in.1,t.in.2,by=c('fipsstr','year'))

cdc.mort.drugalc.crude = rbind(t.in.3,t.in.4)
cdc.mort.drugalc.crude[,mort.ucd.drugalc := mort.ucd.all-mort.ucd.nondrugalc]
cdc.mort.drugalc.crude[,mort.ucd.drugalc.rate := mort.ucd.all.ratecrude-mort.ucd.nondrugalc.ratecrude]
#cdc.mort.drugalc.crude = merge(cdc.mort.drugalc.crude,cnty.lookup,by='fipsstr')
cdc.mort.drugalc.crude = cdc.mort.drugalc.crude[,.(mort.ucd.drugalc,mort.ucd.drugalc.rate,year,fipsstr)]

# Age adjusted Rates

t.in.1=fread(file=t.4$filename[5],
             select=c('County Code','Year','Deaths','Age Adjusted Rate'),
             colClasses=c(`County Code`='character',`Year`='integer',`Deaths`='character',`Age Adjusted Rate`='character'),
             col.names=c(`County Code`='fipsstr',`Year`='year',`Deaths`='mort.ucd.all.adj',`Age Adjusted Rate`='mort.ucd.all.rate.adj')
)

t.in.1[,`:=` (mort.ucd.all.rate.adj = as.numeric(mort.ucd.all.rate.adj),mort.ucd.all.adj=as.numeric(mort.ucd.all.adj))]

t.in.2=fread(file=t.4$filename[6],
             select=c('County Code','Year','Deaths','Crude Rate'),
             colClasses=c(`County Code`='character',`Year`='integer',`Deaths`='character',`Age Adjusted Rate`='character'),
             col.names=c(`County Code`='fipsstr',`Year`='year',`Deaths`='mort.ucd.nondrugalc.adj',`Age Adjusted Rate`='mort.ucd.nondrugalc.rate.adj')
)
t.in.2[,`:=` (mort.ucd.nondrugalc.rate.adj = as.numeric(mort.ucd.nondrugalc.rate.adj),mort.ucd.nondrugalc.adj=as.numeric(mort.ucd.nondrugalc.adj))]


t.in.3= merge(t.in.1,t.in.2,by=c('fipsstr','year'))

t.in.1=fread(file=t.4$filename[7],
             select=c('County Code','Year','Deaths','Age Adjusted Rate'),
             colClasses=c(`County Code`='character',`Year`='integer',`Deaths`='character',`Age Adjusted Rate`='character'),
             col.names=c(`County Code`='fipsstr',`Year`='year',`Deaths`='mort.ucd.all.adj',`Age Adjusted Rate`='mort.ucd.all.rate.adj')
)

t.in.1[,`:=` (mort.ucd.all.rate.adj = as.numeric(mort.ucd.all.rate.adj),mort.ucd.all.adj=as.numeric(mort.ucd.all.adj))]

t.in.2=fread(file=t.4$filename[8],
             select=c('County Code','Year','Deaths','Crude Rate'),
             colClasses=c(`County Code`='character',`Year`='integer',`Deaths`='character',`Age Adjusted Rate`='character'),
             col.names=c(`County Code`='fipsstr',`Year`='year',`Deaths`='mort.ucd.nondrugalc.adj',`Age Adjusted Rate`='mort.ucd.nondrugalc.rate.adj')
)
t.in.2[,`:=` (mort.ucd.nondrugalc.rate.adj = as.numeric(mort.ucd.nondrugalc.rate.adj),mort.ucd.nondrugalc.adj=as.numeric(mort.ucd.nondrugalc.adj))]

t.in.4= merge(t.in.1,t.in.2,by=c('fipsstr','year'))

cdc.mort.drugalc.adj = rbind(t.in.3,t.in.4)

cdc.mort.drugalc.adj[,mort.ucd.drugalc.adj := mort.ucd.all.adj-mort.ucd.nondrugalc.adj]
cdc.mort.drugalc.adj[,mort.ucd.drugalc.rate.adj := mort.ucd.all.rate.adj-mort.ucd.nondrugalc.rate.adj]
# NOTE: With this methodology, age adjusted rates per 100,000 yeild negative results, adj per 100,000 not a linear process, so dropping these rates
# cdc.mort.drugalc.adj = merge(cdc.mort.drugalc.adj,cnty.lookup,by='fipsstr')
# The remaining raw death counts are not age adjusted (only age adjusted RATES, not raw counts, are avail)
cdc.mort.drugalc.adj = cdc.mort.drugalc.adj[,.(mort.ucd.drugalc.adj,year,fipsstr)]

# Suicide Data
setwd(rawpath)
t.in.nonsuicide = fread(file='ucd nonsuicide allyrs.txt',
                        colClasses=c('character','character','character','integer','integer','character','integer','character'),
                        col.names=c('notes','countynameproper','fipsstr','year','yearcode','mort.nonsuicide','pop','mort.nonsuicide.rate')
)
t.in.nonsuicide[,`:=`(mort.nonsuicide=as.integer(mort.nonsuicide),mort.nonsuicide.rate=as.numeric(mort.nonsuicide.rate))]


t.in.withsuicide = fread(file='ucd withsuicide allyrs.txt',
                         colClasses=c('character','character','character','integer','integer','character','integer','character'),
                         col.names=c('notes','countynameproper','fipsstr','year','yearcode','mort.withsuicide','pop','mort.withsuicide.rate')
)
t.in.withsuicide[,`:=`(mort.withsuicide=as.integer(mort.withsuicide),mort.withsuicide.rate=as.numeric(mort.withsuicide.rate))]

cdc.mort.suicide = merge(t.in.nonsuicide[,.(fipsstr,year,mort.nonsuicide,pop,mort.nonsuicide.rate)],
                         t.in.withsuicide[,.(fipsstr,year,mort.withsuicide,mort.withsuicide.rate)],
                         by=c('fipsstr','year'))
cdc.mort.suicide[, `:=` (mort.ucd.suicide = as.numeric(mort.withsuicide)-as.numeric(mort.nonsuicide),
                         mort.ucd.suicide.rate = as.numeric(mort.withsuicide.rate)-as.numeric(mort.nonsuicide.rate))]

cdc.mort.suicide = cdc.mort.suicide[,.(mort.ucd.suicide,year,fipsstr)]

# Read in death/population data
setwd(rawpath)
t.in=fread('ucd all deaths pop.txt',
           select=c('County Code','Year','Deaths','Population'),
           colClasses=c(`County Code`='character',`Year`='integer',`Deaths`='character',`Population`='character'),
           col.names=c(`County Code`='fipsstr',`Year`='year',`Deaths`='mort.ucd.all',`Population`='pop')
)
cdc.mort.all = t.in[,`:=`(mort.ucd.all = as.integer(mort.ucd.all), pop = as.integer(pop))]
# Create xt framework: 1999-2016
cnty.lookup.year=data.table()
for (yr in 1999:2016){
   t = cnty.lookup[,year:=yr]
   cnty.lookup.year = rbind(t,cnty.lookup.year)
}

cdc.mort = cnty.lookup.year %>% 
    merge(y=cdc.mort.drugalc.crude,by=c('fipsstr','year'),all.x=T) %>% 
    merge(y=cdc.mort.opioid,by=c('fipsstr','year'),all.x=T) %>% 
    merge(y=cdc.mort.suicide,by=c('fipsstr','year'),all.x=T) %>% 
    merge(y=cdc.mort.all,by=c('fipsstr','year'),all.x=T)

cdc.mort=cdc.mort[,.(statefipsn,cntyfipsn,year,mort.ucd.drugalc,mort.ucd.opioid,mort.ucd.suicide,mort.ucd.all,pop)]

cdc.mort[,mort.ucd.despair := mort.ucd.drugalc +mort.ucd.opioid+mort.ucd.suicide]


datvars = c('mort.ucd.drugalc','mort.ucd.suicide','mort.ucd.despair','mort.ucd.all')
gen.pc(cdc.mort,datvars,'pop','.pc')
datvars = c('mort.ucd.drugalc','mort.ucd.suicide')
gen.pc(cdc.mort,datvars,'mort.ucd.all','.pd')
# save(cdc.mort,file=paste(datpath,'cdc_mort.Rdata',sep=''))

######### Generate county level data (summarize/sum across years)
cdc.mort.cnty = cdc.mort[,0,by=c('statefipsn','cntyfipsn')][,1:2]
# Sort recent years to top, for discsum function
cdc.mort = cdc.mort[order(statefipsn,cntyfipsn,-year)]
discsum = function(x,rho) {
   rho.n = rep(rho,length(x))
   power.n = seq(0,length(x)-1,1)
   discfac = rho.n^power.n
   discsum = sum(x*discfac)
   return(discsum)
}
# Main Loop
varlist = c('mort.ucd.drugalc','mort.ucd.opioid','mort.ucd.suicide','mort.ucd.despair','mort.ucd.all','pop')
for (var in varlist) {
   varname = paste(var,'.12',sep='')
   t=cdc.mort[year>=2012, sum(get(var)),by=c('statefipsn','cntyfipsn')]
   setnames(t,'V1',varname)
   cdc.mort.cnty=merge(cdc.mort.cnty,t)
   
   varname = paste(var,'.8',sep='')
   t=cdc.mort[year>=2008, sum(get(var)),by=c('statefipsn','cntyfipsn')]
   setnames(t,'V1',varname)
   cdc.mort.cnty=merge(cdc.mort.cnty,t)
   
   varname = paste(var,'.disc95',sep='')
   t=cdc.mort[, discsum(get(var),.95),by=c('statefipsn','cntyfipsn')]
   setnames(t,'V1',varname)
   cdc.mort.cnty=merge(cdc.mort.cnty,t)
}

# avgpop = cdc.mort[,.(avgpop = mean(pop)), by=.(statefipsn,cntyfipsn)]
# cdc.mort.cnty = merge(cdc.mort.cnty,avgpop)

varlist = c('mort.ucd.drugalc','mort.ucd.opioid','mort.ucd.suicide','mort.ucd.despair')
suffixlist = c('.12','.8','.disc95')
for (var in varlist) {
   for (suffix in suffixlist) {
      cdc.mort.cnty[, paste(var,suffix,'.pcpy',sep=''):= get(paste(var,suffix,sep=''))/get(paste('pop',suffix,sep=''))]
      cdc.mort.cnty[, paste(var,suffix,'.pdpy',sep=''):= get(paste(var,suffix,sep=''))/get(paste('mort.ucd.all',suffix,sep=''))]  
   }
}


      
avgpop = cdc.mort[,.(avgpop = mean(pop)), by=.(statefipsn,cntyfipsn)]
cdc.mort.cnty = merge(cdc.mort.cnty,avgpop)

save(cdc.mort,cdc.mort.cnty,file=paste(datpath,'cdc_mort.Rdata',sep=''))

# Superceeded code:
# rawpath = "research/proj_010_trump/data/raw"
# setwd(paste(gdrivepath,rawpath,sep=''))
# wrkdata = data.table()
# yrstart = c(2000,2004,2008,2012)
# for (yr in yrstart) {
#    yrend = yr + 3
#    filename = paste('mcd drugs alc ',yr,' to ',yrend,'.txt',sep='')
#    #print(filename)
#    t.data = fread(file=filename,
#                    col.names=c('notes','cname','fipsstr','cod','codcode','deaths','pop','ratecrude','rateadj'),
#                    colClasses=c(`County Code`='character'))
#    t.data = t.data[,.(fipsstr,cod,codcode,deaths,ratecrude,rateadj)]
#    t.data[,yrstart := yr]
#    t.data[,yrend := yr+3]
#    wrkdata = rbind(wrkdata,t.data)
# }
# # Add section for treatment of suppressed and unreliable values
# wrkdata = merge(wrkdata,cnty.lookup,by='fipsstr')
# wrkdata = wrkdata[,.(cod,codcode,deaths,ratecrude,rateadj,statefipsn,cntyfipsn,yrstart,yrend)]
# 
# 
# #cdc.mcod.drugalc
# 
# # Opiod deaths
# # All deaths
# t.data1 = fread(file='mcd opiod all.txt',
#                colClasses=c(`County Code`='character',Population = 'character'),
#                col.names=c('notes','cname','fipsstr','deathsAllop','pop','ratecrude','rateajd')
# )
# 
# t.data1 = t.data1[notes=='',.(fipsstr,deathsAllop,ratecrude,rateajd)]
# # Broken down by type of opiod
# t.data2 = fread(file='mcd opoid bytype.txt',
#                 colClasses=c(`County Code`='character'),
#                 col.names=c('notes','cname','fipsstr','cod','codcode','deaths','pop','ratecrude','rateadj')
# )
# t.data2 = t.data2[,.(fipsstr,cod,codcode,deaths,ratecrude,rateadj)]
# t.data2.1 = dcast(t.data2,fipsstr~codcode,value.var=c('deaths','ratecrude','rateadj'))
# # Merge them together
# cdc.mcod.opiod = merge(t.data1,t.data2.1,by='fipsstr')
# 
# # Read in death/population data
# t.data
# print('end')




# Read in opiod data





