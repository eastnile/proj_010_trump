loadall()
mod = list()
column.labels = c('OLS', 'Probit', 'Logit', 'Probit (No FE)', 'Probit (No Weights)', 'Probit (Horse-race)')
column.separate = c(2, 2, 2, 2, 2, 2)
dep.var.labels = rep(c('Trump G.E.', ' Trump Prim.'), 6)
omit = c('.data_')
v.y = c('cc.TrumpGEVote', 'cc.TrumpPVote')

# Feature Scaling
isdum = sapply(ccesplus, function(x) { all(x %in% c(0:1, NA)) })
isnumeric = sapply(ccesplus, is.numeric)
norescale = isdum | !isnumeric
t = as.data.frame(ccesplus)
ccesplus.fscaled = as.data.frame(ccesplus)
ccesplus.fscaled[!norescale] = scale(t[!norescale])


for (var in v.y) {
    #var = 'cc.TrumpGEVote'
    ## With State FEs
    # OLS
    mod$probit.fscaled$m[[var]] = lm(formula = formula, data = ccesplus.fscaled, weights = ccesplus$cc.commonweight)

}

stargazer(c(mod),
          type = 'text',
          title = 'Regressions',
          report = 'vc*sp',
          covariate.labels = xlabels,
          column.labels = column.labels,
          column.separate = column.separate,
          #dep.var.labels = dep.var.labels,
          model.names = F,
          model.numbers = F,
          omit = c('stateabr')
          )
