p.primaries = paste(gdrivepath,'research/proj_010_trump/data/primaries.Rdata',sep='')
p.crash = paste(gdrivepath,'research/proj_010_trump/data/crash.Rdata',sep='')
p.taa = paste(gdrivepath,'research/proj_010_trump/data/taa.Rdata',sep='')

load(p.primaries)
load(p.crash)
load(p.taa)

require(plm)

data('Grunfeld',package='plm')
E=pdata.frame(Grunfeld,index=c('firm','year'),row.names=F)
reg = plm(inv ~ value + capital, data = Grunfeld, model='within',effect='twoways')
summary(reg)
fixef(reg,effect='time')


adata = cnty.lookup %>% 
        merge(y=crashcnty,by=c('statefipsn','cntyfipsn')) %>%
        merge(y=taaCnty,by=c('statefipsn','cntyfipsn')) %>%
        merge(y=crashrust,by=c('statefipsn','cntyfipsn'))

reg = lm(nworkers ~ crash4,adata)
summary(reg)

reg = plm(nworkers ~ crash4,adata,model='within',index=c('statefipsn')) 
summary(reg)

setwd(paste(gdrivepath,'research/proj_010_trump/data/',sep=''))

fwrite(adata,'adata.csv')



wrkdata = merge(cnty.lookup,primaries.r.cnty,by=c('statefipsn','cntyfipsn'),all.x=TRUE)

crashrust = crashrust[,1:7]

wrkdata = merge(wrkdata,crashrust,by=c('statefipsn','cntyfipsn'),all.x=TRUE)

plot(wrkdata$crashrel,wrkdata$votepct_dt)

map.allind(wrkdata,'votepct_dt')

a=merge(cnty.lookup,primaries.cnty,all.x=TRUE,by=c('statefipsn','cntyfipsn'))

b=merge(a,crashcnty,all.x=TRUE,by=c('statefipsn','cntyfipsn'))

b[,totalvote_d:=totvote_d_bs]
b[,totalvote_r:=totvote_r_dt]

require(dplyr)

b=select(b, -contains('totvote_d_'))

b=select(b, -contains('totvote_r_'))

path = paste(gdrivepath,'research/proj_010_trump/data/dataforjohn.csv',sep='')
write.csv(b,file=path)