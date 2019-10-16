require(ggplot2)
require(lubridate)
require(gridExtra)
require(reshape2)
require(data.table)

load(paste(gdrivepath,"research/data/qwi/","qwi_allvars_naics2_allpersons_allcnty.Rda",sep=""))
wrkdata = qwiNaics2[,.(Emp,EmpTotal,EmpS,Payroll,industry,state,county,dt)]

# Compute HHI Index
wrkdata = qwiNaics2[,.(Emp,EmpTotal,EmpS,Payroll,industry,state,county,dt)]
wrkdata[, EmpAllInd:= sum(EmpTotal, na.rm=TRUE), by = c("dt","state","county")]
wrkdata[, EmpIndPct:= EmpTotal/EmpAllInd]
wrkdata[, EmpIndPctSq:= EmpIndPct^4]
hhi = wrkdata[,.(hhi=sum(EmpIndPctSq, na.rm=TRUE)), by=c("dt","state","county")]
# Drop when HHI =  zero
hhi = hhi[hhi != 0]

# Compute max, min, and the difference in HHI over entire time frame
hhisummary = hhi[, list(HhiMax = max(hhi, na.rm=TRUE), HhiMin = min(hhi,na.rm=TRUE), HhiAvg=mean(hhi,na.rm=TRUE),HhiSd=sd(hhi,na.rm=TRUE)), by=c("state","county")]
hhisummary[, HhiDiff:=HhiMax-HhiMin]
hhisummary = hhisummary[order(HhiDiff)]
hhisummary[, fips:=as.numeric(paste0(state,county))]
hhisummary[, fipsstr:=(paste0(state,county,sep=""))]
#hist(hhisummary$HhiDiff)
# compare = merge(hhisummary,ttacnty, by="fipsstr", all=TRUE)
# cor(compare$HhiAvg,compare$npetitions,use="pairwise.complete.obs")

#================

# Identify counties where the top industry "crashes"
wrkdata = qwiNaics2[,.(Emp,EmpTotal,EmpS,Payroll,industry,state,county,dt)]
wrkdata[, EmpIndRank:= rank(-EmpTotal, na.last=TRUE,ties.method="first"), by =.(dt,state,county)]
wrkdata[, EmpIndMax:= max(EmpTotal, na.rm=TRUE), by =.(industry,state,county)]
wrkdata[, EmpIndMin:= min(EmpTotal, na.rm=TRUE), by =.(industry,state,county)]

# Identify dates of max/min employment, by industry
wrkdata[EmpTotal==EmpIndMax,dateMax:=dt]
wrkdata[EmpTotal==EmpIndMin,dateMin:=dt]

# Identify rank of industry when it maxes out
wrkdata[EmpTotal==EmpIndMax,maxRank:=EmpIndRank]
# Replicate these values, filling out the datatable by industry
wrkdata[,dateMax:=max(dateMax,na.rm=TRUE), by=.(industry,state,county)]
wrkdata[,dateMin:=max(dateMin,na.rm=TRUE), by=.(industry,state,county)]
wrkdata[,maxRank:=as.integer(max(maxRank,na.rm=TRUE)), by=.(industry,state,county)]
wrkdata[,crashsize:=EmpIndMax/EmpIndMin, by=.(industry,state,county)]
# wrkdata[,crashrank:=as.integer(rank(-crashsize,na.last=TRUE,ties.method="first")), by=.(dt,state,county)]

# Identify "crashing" counties/industries
crashthreshold = 2
crashts = wrkdata[maxRank==1 & dateMax<dateMin & crashsize > crashthreshold,]

# Some counties have more than one "crashing" industry; select the crashiest one
crashts[,crashsizemax:=max(crashsize,na.rm=TRUE),by=.(state,county)]
crashtsmax=crashts[crashsize==crashsizemax]
crashcnty = crashtsmax[,.(crashsize = max(crashsize)),by=.(industry,state,county)]
crashcnty[,fipsstr:=paste(state,county,sep="")]

# Check to see if the crash variable correlates with TAA claims
# Load TAA data into memory
path = paste(gdrivepath,"research/proj_010_trump/data/taa.Rdata",sep="")
load(path)
path = paste(gdrivepath,"research/data/lookup/USA lookups.Rdata",sep="")
load(path)

adata = merge(cnty.lookup,crashcnty, by="fipsstr", all=TRUE)
adata = merge(adata,taaCnty, by="fipsstr",all=TRUE)
adata[is.na(crashsize),crashsize:=0]
adata[crashsize==Inf,crashsize:=NA,]
adata[,i.crashsize:=0]
adata[crashsize>0,i.crashsize:=1]


cor(adata$i.crashsize, adata$nworkers,use = "complete.obs")
cor(adata$npetitions, adata$nworkers,use = "complete.obs")
# Collapse:
# y=x[,.(mean=mean(a)),by=.(b)]
# Egen:
# y=x[,mean:=mean(a),by=.(b)]
# Standbox:

require(choroplethr)
require(choroplethrMaps)
plotdata = data.table(region=as.numeric(adata$fips),value=adata$crashsize)
county_choropleth(plotdata)

plotdata = data.table(region=as.numeric(hhisummary$fips),value=hhisummary$HhiDiff)
county_choropleth(plotdata)


# Suffolk MA (boston) 25025
# gary IN 18089
# knox county 17095
# Detroit 26163

st1 = "26"
cnty1 = "163"

#tester = wrkdata[state==st1&county==cnty1,]

county = qwiNaics2[state ==st1 & county == cnty1]
county[,dt:=yq(time)]
county[,Emp:=as.numeric(EmpTotal)]

ggplot(data = county, aes(x=dt,y=EmpTotal)) + 
  geom_line(aes(color=industry), size=1) + 
  scale_x_date(date_breaks ="1 year") +
  theme(axis.text.x=element_text(angle=60, hjust=1))



hhicounty = hhi[state ==st1 & county == cnty1]

g2 = ggplot(data = hhicounty, aes(x=dt,y=hhi)) + 
  geom_line(size=1) + 
  scale_x_date(date_breaks ="1 year") +
  theme(axis.text.x=element_text(angle=60, hjust=1))

grid.arrange(g1,g2,nrow =2)

ggplot(data = county, aes(x=dt,y=EmpEndHhi)) + 
  geom_line(aes(color=industry), size=1) + 
  scale_x_date(date_breaks ="1 year") +
  theme(axis.text.x=element_text(angle=60, hjust=1))

plot(a,b)

tester = economics

ggplot(data = tester, aes(x = date, y = psavert))+
  geom_line(color = "#00AFBB", size = 2)


ggplot(data = tester, aes(x = date, y = psavert)) + geom_line()


a = c(1,2,3,4,5,6,7,8,9,10)
b = c(1,1,1,1,1,2,2,2,2,2)
c = c(1,1,2,2,3,3,1,1,2,2)

d = data.table(a,b,c)

d[, max:=max(a, na.rm=TRUE), by = c("b","c")]


tester = function(x){
  return(x*2)
}

c[, (cols) := lapply(.SD,tester), .SDcols = cols]

c[,c("a","b") := lapply(.SD,tester), .SDcols = c("a","b")]

c[,c("a","b","e") := .(a*2,b*2,a+b)]


data = data[,lapply(.SD,as.numeric), .SDcols = varnames]

# Old Code:
# Note: dcast like this: dcast(data, i_vars ~ j_var, value.var = c("","", value vars), drop=TRUE)
# Old reshape code: qwicnty = reshape(qwicnty, idvar = c("state","county","dt"),timevar="industry",direction="wide")
#qwicnty = dcast.data.table(qwicnty, state+county+dt ~ industry, value.var=c("Emp","EmpTotal","EmpS","Payroll"), drop=c(TRUE,FALSE))
