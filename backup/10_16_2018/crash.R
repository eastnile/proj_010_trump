# Crash Investigation
setproj(10)
require(reshape2)
require(zoo)
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
         width = 12, FUN=function(x) mean(x, na.rm = FALSE), 
         align = 'right', partial = TRUE, fill=c(NA,NA,NA)),
      by = .(cntyfipsn,statefipsn,industry)]
}

t.p = paste(gdrivepath,'research/proj_010_trump/data/qwiNaics2sm.Rdata',sep='')
save(wrkdata,file=t.p)

# Compute Crash Scores

load(t.p)
# Remove industries for which all data is NA
wrkdata[, t.miss:= 0]
wrkdata[ is.na(EmpTotalSm)|EmpTotalSm==0, t.miss:=1]
wrkdata[, nmiss := sum(t.miss), by=.(industry,statefipsn,cntyfipsn)]
wrkdata[, ndt := sum(.N), by=.(industry,statefipsn,cntyfipsn)]
# allmiss = wrkdata[nmiss == ndt]
wrkdata=wrkdata[nmiss != ndt,1:6]

# Generate Needed Info
wrkdata[, indcount:= sum(.N), by =.(dt,statefipsn,cntyfipsn)]
wrkdata[, indrank := rank(-EmpTotalSm, na.last=TRUE,ties.method="first"), 
                         by =.(dt,statefipsn,cntyfipsn)]
wrkdata[, totaljobs:= sum(EmpTotalSm, na.rm=TRUE), by =.(dt,statefipsn,cntyfipsn)]
wrkdata[, indpct:= EmpTotalSm/totaljobs]
wrkdata[, indmax:= max(EmpTotalSm, na.rm=TRUE), by =.(industry,statefipsn,cntyfipsn)]
wrkdata[, idt := rowid(industry,statefipsn,cntyfipsn)]
wrkdata[!is.na(EmpTotalSm), lastidt := max(idt), by =.(industry,statefipsn,cntyfipsn)]
wrkdata[, lastidtcnty := max(lastidt,na.rm=TRUE), by=.(statefipsn,cntyfipsn)]
wrkdata[, maxempcnty := max(totaljobs,na.rm=TRUE),by=.(statefipsn,cntyfipsn)]


# Crash is defined as present-peak. By industry, extract info for peak and present period
t1 = wrkdata[EmpTotalSm==indmax,.(indrankmax = max(indrank), indmax=max(EmpTotalSm),
             indmaxpct=max(indpct), dtmax = max(dt), totaljobsmax = max(totaljobs)),by =.(industry,statefipsn,cntyfipsn)] 
# Still need max within function to break ties
t2 = wrkdata[idt == lastidt,.(indfin = EmpTotalSm, indrankfin = indrank, 
             indfinpct =indpct, dtfin = dt, totaljobsfin = totaljobs),by =.(industry,statefipsn,cntyfipsn)]

crash = merge(t1,t2)
crash[,crashppl := indmax-indfin]
crash[,crashpct := (indmax-indfin)/indmax]
crash[,crashpc := (indmax-indfin)/totaljobsmax]
crash[,falltime := dtfin-dtmax]
crash[,crashrate := crashppl/as.integer(falltime)]

# Compute county level crash variables
# By what percentage did industries in this county contract, relative to their peak?
t1 = crash[, .(crashmag = sum(crashpct)),
           by=.(statefipsn,cntyfipsn)]
# How many people participated in a crash? What is the total number of jobs lost in a crash?
t2 = crash[, .(crashppl = sum(crashppl),
                crashppl.w = sum(indmaxpct*crashppl),
                crashppl.w.sharp = sum(indmaxpct^4 * crashppl)),
            by=.(statefipsn,cntyfipsn)]
# What percentage of people in the county experienced a crash?
t3 = crash[, .(crashpc = sum(crashpc),
                crashpc.w = sum(indmaxpct*crashpc),
                crashpc.w.sharp = sum(indmaxpct^4 * crashpc)),
            by=.(statefipsn,cntyfipsn)]
# Same as the '.w' varaibles above, but simply taking top 3 instead of weighting by industry size.
t4 = crash[indrankmax <= 3, .(crashmag.top3 = sum(crashpct),
                             crashppl.top3 = sum(crashppl),
                             crashpc.top3 = sum(crashpc)),
            by=.(statefipsn,cntyfipsn)]
# Get mean employment as this is useful
tt5 = wrkdata[,.(empmean = mean(EmpTotalSm,na.rm=TRUE)),
           by=.(industry,statefipsn,cntyfipsn)]
t5 = tt5[,.(empmeantot = sum(empmean,na.rm=TRUE)),
           by=.(statefipsn,cntyfipsn)]
crashcnty = t1  %>% merge(y=t2) %>% merge(y=t3) %>% merge(y=t4) %>% merge(y=t5)
crashcnty[,crashppl.pc := crashppl/empmeantot]

# Compute crash of total employment (combining all industries)
t1 = wrkdata[totaljobs==maxempcnty,.(maxemp = max(totaljobs),maxempdt=max(dt)),by=.(statefipsn,cntyfipsn)]
t2 = wrkdata[idt==lastidtcnty,.(empfin=max(totaljobs),empfindt=max(dt)),by=.(statefipsn,cntyfipsn)]
t3 = merge(t1,t2,by=c('statefipsn','cntyfipsn'))
t3[,crashallppl:=maxemp-empfin]
t3[,crashallpct:=(maxemp-empfin)/maxemp]
t3[,crashalltime:=as.numeric(empfindt-maxempdt)]
t3[,crashallrate:=crashallppl/crashalltime]
t3[,crashallpctrate:=crashallpct/crashalltime]
t3[is.na(crashallrate),crashallrate := 0]
t3[is.na(crashallpctrate),crashallpctrate := 0]

# Merge in
crashcnty = merge(crashcnty,t3[,c(1:2,7:9)])

# Examine manufactoring only
crashrust = crash[industry=='31-33',.(crashppl,crashpct,indrankmax,indmaxpct,totaljobsmax),by=.(statefipsn,cntyfipsn)]
setnames(crashrust,c('crashppl','crashpct'),c('rustppl','rustpct'))
crashrust = crashrust[,rustpc := rustppl/totaljobsmax]
crashcnty = merge(crashcnty,crashrust[,.(statefipsn,cntyfipsn,rustppl,rustpct,rustpc)])
# Generate percentile ranks
datvars = names(select(crashcnty,contains('crash'),contains('rust')))
for (var in datvars) {
   crashcnty[, paste0(var,'.rk') := rank(get(var))/length(get(var))]
}

# Save file
path = paste(gdrivepath,'research/proj_010_trump/data/crash.Rdata',sep='')
save(crash,crashcnty,file=path)

# Sandbox


# Analysis

t.cor = cor(select(crashcnty,contains('.rk')))

require('colorspace')
require('gplots')
cols2 = diverge_hsv(100,alpha=1)
t.cor.round = round(t.cor, digits = 2)
heatmap.2( t.cor, Rowv=F, Colv=F, dendrogram='none', key=F, col = cols2,symm=T,trace='none',lwid=c(.01,.99),lhei=c(.01,.99),margins = c(10,10),cellnote=t.cor.round,notecol='black')

# Crashpc = crashmag.w.rk
# crashpc.w.sharp = crashmag.w.shark



crashcnty = crashcnty[order(crashppl)]

crashcnty = crashcnty[order(crashscore2)]

t = crashcnty[statefipsn ==17 & cntyfipsn == 95]

plot.allind(wrkdata,'EmpTotalSm',48,159)

plot.allind(wrkdata,'EmpTotalSm',17,95)

map.cnty(crashcnty,crashpc.top3,9)

# # Compute before and after peak mean values, to exclude "one year wonders", maybe due to fracking, etc.
# t1 = wrkdata[EmpTotalSm==indmax,dtmax := dt,by =.(industry,statefipsn,cntyfipsn)] 
# t1 = t1[,dtmax:=max(dtmax,na.rm=T),by=.(industry,statefipsn,cntyfipsn)]
# t2 = t1[dt<=dtmax,.(empPremax = mean(EmpTotalSm,na.rm=T)),by=.(industry,statefipsn,cntyfipsn)]
# t3 = t1[dt>=dtmax,.(empPostmax = mean(EmpTotalSm,na.rm=T)),by=.(industry,statefipsn,cntyfipsn)]
# crash = merge(crash,t2)
# crash = merge(crash,t3)
# crash[,prepostdif := (empPremax-empPostmax)/empPremax]
# crashcnty = merge(crashcnty,cnty.lookup,by=c('statefipsn','cntyfipsn'),all.x=TRUE)

# For manufactoring only







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
