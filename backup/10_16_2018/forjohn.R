loadmain()
reg.guide = gsgetregvars()
cces.small = ccesplus[,reg.guide$varname.raw,with=F]
fwrite(cces.small,'cess_prereg.csv')
