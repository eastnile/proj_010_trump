# Crash Investigation
require(reshape2)
require(data.table)
require(zoo)
require(lubridate)

setwd(paste(gdrivepath,'research/proj_010_trump',sep=''))
source('fCrash.R')

# Load Data
load(paste(gdrivepath,"research/data/qwi/",
           "qwi_allvars_naics2_allpersons_allcnty.Rda",sep=""))
load(paste(gdrivepath,'research/data/lookup/USA lookups.RData',sep=''))

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

t.p = paste(gdrivepath,'research/proj_010_trump/data/qwiNaics2sm.Rdata',sep='')
save(wrkdata,file=t.p)
load(t.p)

# Remove industries for which all data is NA
wrkdata[, t.miss:= 0]
wrkdata[ is.na(EmpTotalSm)|EmpTotalSm==0, t.miss:=1]
wrkdata[, nmiss := sum(t.miss), by=.(industry,statefipsn,cntyfipsn)]
wrkdata[, ndt := sum(.N), by=.(industry,statefipsn,cntyfipsn)]
# allmiss = wrkdata[nmiss == ndt]
wrkdata=wrkdata[nmiss != ndt,1:6]

# Generate Crash Info
wrkdata[, indcount:= sum(.N), by =.(dt,statefipsn,cntyfipsn)]
wrkdata[, indrank := rank(-EmpTotalSm, na.last=TRUE,ties.method="first"), 
                         by =.(dt,statefipsn,cntyfipsn)]
wrkdata[, indtot:= sum(EmpTotalSm, na.rm=TRUE), by =.(dt,statefipsn,cntyfipsn)]
wrkdata[, indpct:= EmpTotalSm/indtot]
wrkdata[, indmax:= max(EmpTotalSm, na.rm=TRUE), by =.(industry,statefipsn,cntyfipsn)]
wrkdata[, idt := rowid(industry,statefipsn,cntyfipsn)]
wrkdata[!is.na(EmpTotalSm), lastidt := max(idt), by =.(industry,statefipsn,cntyfipsn)]
wrkdata[, lastidtcnty := max(lastidt,na.rm=TRUE), by=.(statefipsn,cntyfipsn)]
wrkdata[, maxempcnty := max(indtot,na.rm=TRUE),by=.(statefipsn,cntyfipsn)]
# wrkdata[,indfin2 :=EmpTotalSm[which(idt == lastidt)], by =.(industry,statefipsn,cntyfipsn)]

t1 = wrkdata[EmpTotalSm==indmax,.(indrankmax = max(indrank), indmax=max(EmpTotalSm),
             indmaxpct=max(indpct), dtmax = max(dt)),by =.(industry,statefipsn,cntyfipsn)] 
# Still need max within function to break ties
t2 = wrkdata[idt == lastidt,.(indfin = EmpTotalSm, indrankfin = indrank, 
             indfinpct =indpct, dtfin = dt),by =.(industry,statefipsn,cntyfipsn)]
crash = merge(t1,t2)
crash[,crashppl := indmax-indfin]
crash[,crashpct := (indmax-indfin)/indmax]
crash[,falltime := dtfin-dtmax]
crash[,crashrate := crashppl/as.integer(falltime)]

t1a = crash[, .(crash1 = sum(indmaxpct * crashpct), 
                crash2 = sum(indmaxpct^4 * crashpct)),
           by=.(statefipsn,cntyfipsn)]
t1b = crash[indrankmax < 3, .(crash3 = sum(crashpct),
                              crash4 = sum(crashppl)),
            by=.(statefipsn,cntyfipsn)]
t2 = wrkdata[,.(empmean = mean(EmpTotal,na.rm=TRUE)),
           by=.(industry,statefipsn,cntyfipsn)]
t3 = t2[,.(emptot = sum(empmean,na.rm=TRUE)),
           by=.(statefipsn,cntyfipsn)]

crashcnty = merge(t1a,t1b,by=c('statefipsn','cntyfipsn'))
crashcnty = merge(crashcnty,t3,by=c('statefipsn','cntyfipsn'))
crashcnty[,crashscore1 := rank(crash1)/length(crash1)]
crashcnty[,crashscore2 := rank(crash2)/length(crash2)]
crashcnty[,crashscore3 := rank(crash3)/length(crash3)]
crashcnty[,crashscore4 := rank(crash4)/length(crash4)]

# Compute crash of total employment (combining all industries)
t1 = wrkdata[indtot==maxempcnty,.(maxemp = max(indtot),maxempdt=max(dt)),by=.(statefipsn,cntyfipsn)]
t2 = wrkdata[idt==lastidtcnty,.(empfin=max(indtot)),by=.(statefipsn,cntyfipsn)]
crashcnty = merge(crashcnty,t1,by=c('statefipsn','cntyfipsn'))
crashcnty = merge(crashcnty,t2,by=c('statefipsn','cntyfipsn'))
crashcnty[,crashcntytot:=maxemp-empfin]
crashcnty[,crashcntypct:=(maxemp-empfin)/maxemp]

# Compute before and after peak mean values, to exclude "one year wonders", maybe due to fracking, etc.
t1 = wrkdata[EmpTotalSm==indmax,dtmax := dt,by =.(industry,statefipsn,cntyfipsn)] 
t1 = t1[,dtmax:=max(dtmax,na.rm=T),by=.(industry,statefipsn,cntyfipsn)]
t2 = t1[dt<=dtmax,.(empPremax = mean(EmpTotalSm,na.rm=T)),by=.(industry,statefipsn,cntyfipsn)]
t3 = t1[dt>=dtmax,.(empPostmax = mean(EmpTotalSm,na.rm=T)),by=.(industry,statefipsn,cntyfipsn)]
crash = merge(crash,t2)
crash = merge(crash,t3)
crash[,prepostdif := (empPremax-empPostmax)/empPremax]
# crashcnty = merge(crashcnty,cnty.lookup,by=c('statefipsn','cntyfipsn'),all.x=TRUE)

# For manufactoring only

crashrust = crash[industry=='31-33',.(crashppl,crashpct,indmaxpct),by=.(statefipsn,cntyfipsn)]
crashrust = crashrust[,crashpplrank:=rank(crashppl)/length(crashppl)]
crashrust = crashrust[,crashrel:=crashpct*indmaxpct]
crashrust = crashrust[,crashrelrank:=rank(crashrel)/length(crashrel)]
crashrust = merge(crashrust,t3,by=c('statefipsn','cntyfipsn'))
# crashrust = merge(crashrust,cnty.lookup,by=c('statefipsn','cntyfipsn'),all.x=TRUE)
setnames(crashrust, 3:ncol(crashrust), paste0('rust.',names(crashrust)[3:ncol(crashrust)]))


path = paste(gdrivepath,'research/proj_010_trump/data/crash.Rdata',sep='')
save(crash,crashcnty,crashrust,file=path)

# Sandbox


# t=crashcnty[order(crash2)]
# t=crashrust[order(crashpplrank)]
# 
# 
# plot.allind(wrkdata,'EmpTotalSm',6,37)
# map.allind(crashrust,'crashrel')




# dt = data.table(a=c(1,2,3,4,5,6),b=c(1,1,1,2,2,2))
# dt[, c:= if (.N==which(a==6)) 1 else 0]
# dt[,c:=max(a),by=b]
# dt[, d:= 0]
# dt[a==c,d:=b]
# dt[,e:=if(d[3]>0) 1 else 0]
# dt = data.table(a=c(0,2,1,0,2,0),b=c(1,1,1,2,2,2))
# dt[,c:=if(a[3]>0) a[which(a==2)] else 0,by=b]






# Generate numeric index of date variable (first date means ndt = 1)
# wrkdata[, idt := rowid(industry,statefipsn,cntyfipsn)]

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
