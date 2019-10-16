require(foreign)
path = paste(gdrivepath,'research/proj_010_trump/data/raw/from john.sav',sep='')
john = read.spss(path,to.data.frame=T)
john = rename(john,statefipsn=statefip)
john = rename(john,cntyfipsn=cntyfips)
john = select(john,statefipsn,cntyfipsn,RepClosedP,RepPMarch15,TrumpCarson,TrumpKasich,TrumpCruz,TrumpStrength)

save(john,file=paste(gdrivepath,'research/proj_010_trump/data/john.Rdata',sep=''))

