# Crash Investigation
require(reshape2)
require(data.table)
require(zoo)
require(ggplot2)
require(lubridate)

# User created functions
eras = function(ts) {
   require(data.table)
   d2 = diff(diff(ts) > 0)
   xmax = which(d2==-1) + 1
   xmin = which(d2== 1) + 1
   xcrit = sort(c(1,xmax,xmin,length(ts)))
   eras = data.table(xbeg = integer(), xend=integer(),dx=integer(), ybeg= numeric(),yend=numeric(),dy=numeric())
   for (i in 1:(length(xcrit)-1)) {
      xbeg = xcrit[i]
      xend = xcrit[i+1]
      ybeg = ts[xcrit[i]]
      yend = ts[xcrit[i+1]]
      dx = xcrit[i+1]-xcrit[i]
      dy = ts[xcrit[i+1]]-ts[xcrit[i]]
      row = data.table(xbeg,xend,dx,ybeg,yend,dy)
      eras = rbind(eras,row)
   }
   return(eras)
}


setwd(paste(gdrivepath,'research/proj_010_trump',sep=''))
source('fCrash.R')

# Load Data
load(paste(gdrivepath,"research/data/qwi/",
           "qwi_allvars_naics2_allpersons_allcnty.Rda",sep=""))

# Generate smoothed time-series variables
wrkdata = qwiNaics2[,.(industry,statefipsn,cntyfipsn,dt,EmpTotal)]
wrkdata = wrkdata[order(statefipsn,cntyfipsn,industry,dt)]
indnames = names(wrkdata)[5:ncol(wrkdata)]
for(vname in indnames){
   wrkdata[, c(paste(vname,"Sm",sep = "")) := 
      rollapply(get(vname), 
         width = 4, FUN=function(x) mean(x, na.rm = FALSE), 
         align = 'right', partial = TRUE, fill=c(NA,NA,NA)),
      by = .(cntyfipsn,statefipsn,industry)]
}

# Generate rank of each industry at each point in time
wrkdata[, indcount:= sum(.N), by =.(dt,statefipsn,cntyfipsn)]
wrkdata[, indrank:= rank(-EmpTotalSm, na.last=TRUE,ties.method="first"), by =.(dt,statefipsn,cntyfipsn)]
# Generate numeric index of date variable (first date means ndt = 1)
wrkdata[, ndt := rowid(industry,statefipsn,cntyfipsn)]

# Create data framework: A list of all industry level timeseries, catalogued in indts$dir
indts$dir = unique(wrkdata[,.(statefipsn,cntyfipsn,industry)])
indts$dir = indts$dir[order(statefipsn,cntyfipsn,industry)]
indts$dir[,id:=.I]
setkey(wrkdata,statefipsn,cntyfipsn,industry)
indts$dat = list()
for (i in 1:nrow(indts$dir)) {
   if (i %% 1000 == 0) {
      print(i)
   }
   indts$dat[[i]] = wrkdata[.(indts$dir$statefipsn[i],indts$dir$cntyfipsn[i],indts$dir$industry[i])]$EmpTotalSm

}

# For each time series, find eras. An era is a period of uninterrupted increase or decrease
require(parallel)
ncores = detectCores()-1
local = makeCluster(ncores)
eraout=parLapply(cl=local,indts$dat,eras)
stopCluster(local)

# Lookup remaining relevant values, such as rank, for each era
indts$era=list()
for (i in 1:length(eraout)) { 
   x = eraout[[i]]
   y1 = wrkdata[.(indts$dir$statefipsn[i],indts$dir$cntyfipsn[i],indts$dir$industry[i]),
                .(ndt,dt,indcount,indrank)]
   y2 = y1[,.(ndt,dt,indrank)]
   setnames(y1,c('dt','indrank'),c('dtbeg','indrankbeg'))
   setnames(y2,c('dt','indrank'),c('dtend','indrankend'))
   ans = merge(x,y1,by.x = 'xbeg',by.y='ndt',all.x=TRUE)
   ans = merge(ans,y2,by.x = 'xend',by.y='ndt',all.x=TRUE)
   ans = ans[,drank := indrankend-indrankbeg]
   setcolorder(ans,c('dtbeg','dtend','xbeg','xend','dx','ybeg','yend','dy','indrankbeg','indrankend','drank','indcount'))
   indts$era[[i]] = ans
}


plot.allind(wrkdata,'EmpTotalSm',1,1)




# Check to see if the crash variable correlates with TAA claims
# Load TAA data into memory
# path = paste(gdrivepath,"research/proj_010_trump/data/taa.Rdata",sep="")
# load(path)
# path = paste(gdrivepath,"research/data/lookup/USA lookups.Rdata",sep="")
# load(path)
# 
# adata = merge(cnty.lookup,crashcnty, by="fipsstr", all=TRUE)
# adata = merge(adata,taaCnty, by="fipsstr",all=TRUE)
# adata[is.na(crashsize),crashsize:=0]
# adata[crashsize==Inf,crashsize:=NA,]
# adata[,i.crashsize:=0]
# adata[crashsize>0,i.crashsize:=1]



#tester = wrkdata[state==st1&county==cnty1,]


# old code
#wrkdata = qwiNaics2[,.(industry,state,county,dt,EmpTotal)]
#wrkdata = wrkdata[,industry:=paste("ind",industry,sep='')]
#wrkdata = dcast.data.table(wrkdata, state+county+dt ~ industry, value.var="EmpTotal")
#a=wrkdata[state=="01", .(dt,state,county,ind11,ind21,ind22)]

# 
# # Identify counties where the top industry "crashes"
# wrkdata = wrkdata[,EmpTotal:=EmpTotalSm]
# 
# wrkdata[, EmpIndRank:= rank(-EmpTotal, na.last=TRUE,ties.method="first"), by =.(dt,state,county)]
# wrkdata[, EmpIndMax:= max(EmpTotal, na.rm=TRUE), by =.(industry,state,county)]
# wrkdata[, EmpIndMin:= min(EmpTotal, na.rm=TRUE), by =.(industry,state,county)]
# 
# # Identify dates of max/min employment, by industry
# wrkdata[EmpTotal==EmpIndMax,dateMax:=dt]
# wrkdata[EmpTotal==EmpIndMin,dateMin:=dt]
# 
# # Identify rank of industry when it maxes out
# wrkdata[EmpTotal==EmpIndMax,maxRank:=EmpIndRank]
# # Replicate these values, filling out the datatable by industry
# wrkdata[,dateMax:=max(dateMax,na.rm=TRUE), by=.(industry,state,county)]
# wrkdata[,dateMin:=max(dateMin,na.rm=TRUE), by=.(industry,state,county)]
# wrkdata[,maxRank:=as.integer(max(maxRank,na.rm=TRUE)), by=.(industry,state,county)]
# wrkdata[,crashsize:=EmpIndMax/EmpIndMin, by=.(industry,state,county)]
# # wrkdata[,crashrank:=as.integer(rank(-crashsize,na.last=TRUE,ties.method="first")), by=.(dt,state,county)]
# 
# # Identify "crashing" counties/industries
# crashthreshold = 2
# crashts = wrkdata[maxRank==1 & dateMax<dateMin & crashsize > crashthreshold,]
# 
# # Some counties have more than one "crashing" industry; select the crashiest one
# crashts[,crashsizemax:=max(crashsize,na.rm=TRUE),by=.(state,county)]
# crashtsmax=crashts[crashsize==crashsizemax]
# crashcnty = crashtsmax[,.(crashsize = max(crashsize)),by=.(industry,state,county)]
# crashcnty[,fipsstr:=paste(state,county,sep="")]
# 
