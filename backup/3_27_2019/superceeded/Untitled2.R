vc <- jacobian %*% vcov %*% t(jacobian)

vcovgood = vcov
vcovgood[is.na(vcovgood)] = 0

vc <- jacobian %*% vcovgood %*% t(jacobian)

vcov <- vcov(model)


load('vcetester.Rdata')



fe = select(main,contains('stateabr_'))

v.x = getReg(2.1, regdir.good)$v.x

dat = main[,v.x,with=F]

maindat = cbind(fe,dat)

tester = cov(maindat,maindat,use='complete.obs')


ccesplus = dummy_cols(ccesplus, select_columns = c('stateabr'), remove_most_frequent_dummy = T)
fenames.cces = names(select(ccesplus, contains('stateabr_')))
main = dummy_cols(main, select_columns = c('stateabr'), remove_most_frequent_dummy = T)
fenames.cnty = names(select(main, contains('stateabr_')))

t = getReg(2.1,regdir.good)
v.y = t$v.y
v.x = t$v.x
v.x = select(v.x,-contains('Rep'))



v.x.withfe = v.x.withfe[!grepl('relig',v.x.withfe)]
v.x.withfe = v.x.withfe[!grepl('stateabr_AK',v.x.withfe)]
v.x.withfe = v.x.withfe[!grepl('stateabr_CO',v.x.withfe)]
v.x.withfe = v.x.withfe[!grepl('stateabr_DC',v.x.withfe)]
v.x.withfe = v.x.withfe[!grepl('stateabr_KS',v.x.withfe)]

v.x.withfe = c(v.x,fenames.cnty)
# v.x.withfe = v.x.withfe[grepl('stateabr_',v.x.withfe)]

v.x.withfe = v.x.withfe[!grepl('Rep',v.x.withfe)]
v.x.withfe = v.x.withfe[!grepl('stateabr_AK',v.x.withfe)]
v.x.withfe = v.x.withfe[!grepl('stateabr_CO',v.x.withfe)]
v.x.withfe = v.x.withfe[!grepl('stateabr_DC',v.x.withfe)]
v.x.withfe = v.x.withfe[!grepl('stateabr_KS',v.x.withfe)]

v.x.withfe = v.x.withfe[!grepl('stateabr_ME',v.x.withfe)]
v.x.withfe = v.x.withfe[!grepl('stateabr_MN',v.x.withfe)]
v.x.withfe = v.x.withfe[!grepl('stateabr_ND',v.x.withfe)]
v.x.withfe = v.x.withfe[!grepl('stateabr_WY',v.x.withfe)]

v.x.withfe = v.x.withfe[!grepl('Rep',v.x.withfe)]

v.x.withfe.trumpstr = filter(v.x.withfe,!str_detect(

for (var in v.y) {
   var = 'trumpstrnorm'
   ## With State FEs
   # OLS
   formula = as.formula(paste(var, "~", paste(v.x.withfe, collapse = '+'),'+0'))
   tester = lm(formula = formula, data = main)
print(summary(tester))
}