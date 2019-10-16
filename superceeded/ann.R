# ANN

require(reshape2)
require(data.table)
require(xts)
require(zoo)
require(ggplot2)

load(paste(gdrivepath,"research/data/qwi/","qwi_allvars_naics2_allpersons_allcnty.Rda",sep=""))

wrkdata = qwiNaics2[,.(industry,state,county,dt,EmpTotal)]
wrkdata = wrkdata[order(state,county,industry,dt)]

#wrkdata = wrkdata[,industry:=paste("ind",industry,sep='')]

#wrkdata = dcast.data.table(wrkdata, state+county+dt ~ industry, value.var="EmpTotal")

#a=wrkdata[state=="01", .(dt,state,county,ind11,ind21,ind22)]

#wrkdata=wrkdata[state=="01",indust

indnames = names(wrkdata)[5:ncol(wrkdata)]
for(vname in indnames){
   wrkdata[,c(paste(vname,"Sm",sep="")):= rollapply(get(vname), 
                                              width=4, 
                                              FUN=function(x) mean(x, na.rm=TRUE), 
                                              align='right', partial=TRUE, fill=NA)
     ,by=.(county,industry)]
}




ggplot() + 
   geom_line(data = a, aes(x = dt, y = ind21), color = "red") +
   geom_line(data = a, aes(x = dt, y = ind21Sm), color = "blue") +
   xlab('data_date') +
   ylab('percent.change')

ts.plot(a$ind11,a$ind11Sm, gpars = list(col = c("black", "red")))


cols=c("ind11","ind21","ind22")
colsnew = c("ind11n","ind21n","ind22n")

for(i in names(a)){
  print [[i]]
}



a[,(colsnew) := lapply(.SD,rollapply,width=4,FUN=function(x) mean(x),partial=TRUE,by=1,by.column=TRUE,fill=NA,align='right'), .SDcols=cols]

z = a$ind21

rollapply(z, width=3, FUN=function(x) mean(x, na.rm=TRUE), by=1, by.column=TRUE, partial=TRUE, fill=NA, align="right")

xts1 = xts(x=a$ind11,order.by=a$dt,frequency = "quarters")

plot.xts(xts1)

b = ts(xts1,frequency=4)
c=decompose(b)

plot.ts(c(c$trend,b))

# Note: dcast like this: dcast(data, i_vars ~ j_var, value.var = c("","", value vars), drop=TRUE)
# Old reshape code: qwicnty = reshape(qwicnty, idvar = c("state","county","dt"),timevar="industry",direction="wide")
#qwicnty = dcast.data.table(qwicnty, state+county+dt ~ industry, value.var=c("Emp","EmpTotal","EmpS","Payroll"), drop=c(TRUE,FALSE))

require(zoo)
library(tidyverse)
require(dplyr)
savings <- economics %>%
  select(date, srate = psavert) %>%
  mutate(srate_ma01 = rollmean(srate, k = 13, fill = NA),
         srate_ma02 = rollmean(srate, k = 25, fill = NA),
         srate_ma03 = rollmean(srate, k = 37, fill = NA),
         srate_ma05 = rollmean(srate, k = 61, fill = NA),
         srate_ma10 = rollmean(srate, k = 121, fill = NA))