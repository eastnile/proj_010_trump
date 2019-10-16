require(magrittr)
path = paste(gdrivepath,'research/proj_010_trump/fCntyToolbox.R',sep='')
source(paste(gdrivepath,'research/proj_010_trump/fCntyToolbox.R',sep=''))

load(paste(gdrivepath,'research/proj_010_trump/data/cdc_mort.Rdata',sep=''))
load(paste(gdrivepath,'research/proj_010_trump/data/crash.Rdata',sep=''))
load(paste(gdrivepath,'research/proj_010_trump/data/primaries.Rdata',sep=''))

tostata = cnty.lookup %>% 
merge(y=cdc.mort[year==2010],by=c('statefipsn','cntyfipsn'))  %>%                      
merge(y=crashcnty,by=c('statefipsn','cntyfipsn')) %>% 
merge(y=primaries.cnty,by=c('statefipsn','cntyfipsn'))


fwrite(tostata,file = paste(gdrivepath,'research/proj_010_trump/data/tostata.csv',sep=''))

datvars = names(cdc.mort)[4:7]

gen.pc(cdc.mort,datvars)

cdc.mort[,mort.ucd.drugalc.pc.log := log(mort.ucd.drugalc.pc,base=10)]

cdc.mort[,mort.ucd.drugalc.pc.hk := mort.ucd.drugalc.pc*100000]
cdc.mort[,mort.ucd.drugalc.adj.pc.hk := mort.ucd.drugalc.adj.pc*100000]
t = cdc.mort[year==2015,]

map.cnty(t,mort.ucd.drugalc.adj.pc.hk,0)


