require(foreign)

p.in = paste0(datpath,'relig.dta')
t.in = read.dta(p.in)
oldnames = names(select(t.in,totadh:hindadh))
newnames = paste0('relig.',gsub('adh','',oldnames))
setnames(t.in,oldnames,newnames)
relig = t.in

load(paste(gdrivepath,'research/data/cntyfacts/pop.Rdata',sep='')
     ,envir=parent.frame())

relig = as.data.table(merge(relig,cntyfacts.pop[year==2010],all.x=T))
datvars = grep('relig',names(relig),value=T)
gen.pc(relig,datvars)
relig = select(relig,matches('.pc'),statefipsn,cntyfipsn)

save(relig,file=paste0(datpath,'relig.Rdata'))
