require(dplyr)
require(magrittr)
require(data.table)
source(paste(gdrivepath,'research/proj_010_trump/fCntyToolbox.R',sep=''))

# Load Lookups
load(paste(gdrivepath,'research/data/lookup/USA lookups.Rdata',sep=''))
load(paste(gdrivepath,'research/data/cntyfacts/geoarea.Rdata',sep=''))
# Load ACS variables
load(paste(gdrivepath,'research/proj_010_trump/data/acs5cnty.Rdata',sep=''))
# Load other data
load(paste(gdrivepath,'research/proj_010_trump/data/cdc_mort.Rdata',sep=''))
load(paste(gdrivepath,'research/proj_010_trump/data/crash.Rdata',sep=''))
load(paste(gdrivepath,'research/proj_010_trump/data/primaries.Rdata',sep=''))
load(paste(gdrivepath,'research/proj_010_trump/data/taa.Rdata',sep=''))
load(paste(gdrivepath,'research/proj_010_trump/data/genelec.Rdata',sep=''))

# Load John's data
require(foreign)
path = paste(gdrivepath,'research/proj_010_trump/data/raw/from john.sav',sep='')
john = read.spss(path,to.data.frame=T)
john = rename(john,statefipsn=statefip)
john = rename(john,cntyfipsn=cntyfips)
john = select(john,statefipsn,cntyfipsn,RepClosedP,RepPMarch15,TrumpCarson,TrumpKasich,TrumpCruz,TrumpStrength)


tostata = cnty.lookup %>% 
merge(y=cdc.mort[year==2011],by=c('statefipsn','cntyfipsn'),all.x=T)  %>%                      
merge(y=crashcnty,by=c('statefipsn','cntyfipsn'),all.x=T) %>% 
merge(y=primaries.cnty,by=c('statefipsn','cntyfipsn'),all.x=T) %>% 
merge(y=cntyfacts.geoarea,by=c('statefipsn','cntyfipsn'),all.x=T) %>% 
merge(y=acs5[year==2011],by=c('statefipsn','cntyfipsn'),all.x=T) %>%
merge(y=taaCnty,by=c('statefipsn','cntyfipsn'),all.x=T) %>%
merge(y=crashrust,by=c('statefipsn','cntyfipsn'),all.x=T) %>%
merge(y=genelec,by=c('statefipsn','cntyfipsn'),all.x=T) %>%
merge(y=john,by=c('statefipsn','cntyfipsn'),all.x=T)


tostata[,popdensity := pop/geo.area.land]

gen.pc(tostata,c('nworkers','npetitions'))
fwrite(tostata,file = paste(gdrivepath,'research/proj_010_trump/data/tostata.csv',sep=''))

datvars = names(cdc.mort)[4:7]

gen.pc(cdc.mort,datvars)

cdc.mort[,mort.ucd.drugalc.pc.log := log(mort.ucd.drugalc.pc,base=10)]

cdc.mort[,mort.ucd.drugalc.pc.hk := mort.ucd.drugalc.pc*100000]
cdc.mort[,mort.ucd.drugalc.adj.pc.hk := mort.ucd.drugalc.adj.pc*100000]
t = cdc.mort[year==2015,]

map.cnty(t,mort.ucd.drugalc.adj.pc.hk,0)


