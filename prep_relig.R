require(foreign)

p.in = paste0(datpath,'relig.dta')
t.in = as.data.table(read.dta(p.in))
oldnames = names(select(t.in,totadh:hindadh))
newnames = paste0('relig.',gsub('adh','',oldnames))
setnames(t.in,oldnames,newnames)
relig = t.in

# Note: NAs here are distinct from zero, but usually indicate a close to zero number.
# For simplicity, replace NAs with zero.

for (var in names(select(relig, contains('relig')))) {
    relig[is.na(get(var)), (var) := 0]
}

# Compute p.c. values
load(paste0(gdrivepath,'research/data/cntyfacts/pop.Rdata'))
relig = as.data.table(merge(relig,cntyfacts.pop[year==2010],all.x=T))
datvars = grep('relig',names(relig),value=T)
gen.pc(relig,datvars)
relig = select(relig,matches('.pc'),statefipsn,cntyfipsn)
save(relig,file=paste0(datpath,'relig.Rdata'))
