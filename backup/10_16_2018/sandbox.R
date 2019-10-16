setproj(10)

reg.guide = gsgetregvars()

source('reg_cces.R')

# gsdat = data.table(gs_read(gs_key(gsKey),ws='ccesplus guide'))
# reg.guide = gsdat[!is.na(include)&is.na(omit.dummy)&is.na(exclude),.(varname.raw,tags,include)]
# 
# 



knit2html('new reg cces.Rmd','tester.html')

