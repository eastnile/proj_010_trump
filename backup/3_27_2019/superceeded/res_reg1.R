# Globals
getReg = function(regid.arg = NULL, regdir.arg) {
  if (is.null(regid.arg)) {
    t = regdir.arg
    print('yo')
  } else {
    t = regdir.arg[regid %in% regid.arg]
    print('mama')
  }
  
  t = t[order(table.order1, table.order2)]
  v.x = t[include != 'y']$varname.raw
  v.y = t[include == 'y']$varname.raw
  print(t)
  xlabels = t[include != 'y']$varname.print
  # regdata = as.data.frame(ccesplus[, c(v.x.withfe, v.y), with = F])
  reg = list()
  #reg$formula = as.formula(paste(v.y, "~", paste(v.x, collapse = '+')))
  reg$v.x = v.x
  reg$v.y = v.y
  return(reg)
}

regdir.good = data.table(gs_read(gstarget, ws = 'regdir'))
regdir.cces.interact = data.table(gs_read(gstarget, ws = 'ccesplus guide'))
regdir.cnty.interact = data.table(gs_read(gstarget, ws = 'cnty interactive'))

loadmain()

# Feature Scaling
isdum = sapply(main, function(x) { all(x %in% c(0:1, NA)) })
isnumeric = sapply(main, is.numeric)
norescale = isdum | !isnumeric
t = as.data.frame(main)
main.fscaled = as.data.frame(main)
main.fscaled[!norescale] = scale(t[!norescale],center=F)

isdum = sapply(ccesplus, function(x) { all(x %in% c(0:1, NA)) })
isnumeric = sapply(ccesplus, is.numeric)
norescale = isdum | !isnumeric
t = as.data.frame(ccesplus)
ccesplus.fscaled = as.data.frame(ccesplus)
ccesplus.fscaled[!norescale] = scale(t[!norescale],center=F)


# County Level Regressions

t = getReg(1.1,regdir.good)
v.y = t$v.y
v.x.withfe = t$v.x

modcnty = list()
for (var in v.y) {
  #var = 'cc.TrumpGEVote'
  ## With State FEs
  # OLS
  formula = as.formula(paste(var, "~", paste(v.x.withfe, collapse = '+')))
  modcnty$ols$m[[var]] = lm(formula = formula, data = main)
  # Feature Scaled
  formula = as.formula(paste(var, "~", paste(v.x.withfe, collapse = '+')))
  modcnty$ols.fscaled$m[[var]] = lm(formula = formula, data = main.fscaled)
}

modcces = list()
t = getReg(1.1,regdir.good)
v.y = t$v.y
v.x.withfe = t$v.x
v.x = v.x.withfe[! v.x.withfe %in% 'stateabr']

for (var in v.y) {
  # OLS
  formula = getReg(regid, regdir)$formula
  modcces$ols$m[[getReg(regid, regdir)$v.y]] = lm(formula = formula,
                                              data = ccesplus,
                                              weights = ccesplus$cc.commonweight)
  # Probit
  # This will produce a warning about non-integer #successes; it's because of the weights
  formula = getReg(regid, regdir)$formula
  modcces$probit$m[[getReg(regid, regdir)$v.y]] = glm(formula = formula,
                                                  data = ccesplus,
                                                  family = binomial(link = 'probit'),
                                                  weights = ccesplus$cc.commonweight)
  # Logit
  formula = getReg(regid, regdir)$formula
  modcces$logit$m[[getReg(regid, regdir)$v.y]] = glm(formula = formula,
                                                 data = ccesplus,
                                                 family = binomial(link = 'logit'),
                                                 weights = ccesplus$cc.commonweight)
  # No FEs
  formula = getReg(regid, regdir)$formula
  modcces$probit.nofe$m[[getReg(regid, regdir)$v.y]] = glm(formula = formula,
                                                       data = ccesplus,
                                                       family = binomial(link = 'probit'),
                                                       weights = ccesplus$cc.commonweight)
  # No weights
  formula = getReg(regid, regdir)$formula
  modcces$probit.noweights$m[[getReg(regid, regdir)$v.y]] = glm(formula = formula,
                                                            data = ccesplus,
                                                            family = binomial(link = 'probit'))
  # Feature Scaled
  formula = getReg(regid, regdir)$formula
  modcces$probit.fscaled$m[[getReg(regid, regdir)$v.y]] = glm(formula = formula,
                                                          data = ccesplus.fscaled,
                                                          family = binomial(link = 'probit'),
                                                          weights = ccesplus$cc.commonweight)
}
