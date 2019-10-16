# Globals
loadmain()
regdir = data.table(gs_read(gstarget, ws = 'regin'))

# FEs
ccesplus = dummy_cols(ccesplus, select_columns = c('stateabr'), remove_most_frequent_dummy = T)
fenames.cces = names(select(ccesplus, contains('stateabr_')))
main = dummy_cols(main, select_columns = c('stateabr'), remove_most_frequent_dummy = T)
fenames.cnty = names(select(main, contains('stateabr_')))


# County Level Regressions
t = getReg(2.1,regdir.good)
v.y = t$v.y
v.x = t$v.x
v.x.withfe = c(v.x, fenames.cnty)
statemiss = c('AK', 'CO', 'DC', 'KS', 'ME', 'MN', 'ND', 'WY')
t = paste0('stateabr_', statemiss)
v.x.withfe = setdiff(v.x.withfe,t)

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

# CCES Regressions
modcces = list()
t = getReg(1.1,regdir.good)
v.y = t$v.y
v.x = t$v.x
v.x.withfe = c(v.x, fenames.cces)

for (var in v.y) {
  # OLS
  formula = as.formula(paste(var, "~", paste(v.x.withfe, collapse = '+')))
  modcces$ols$m[[var]] = lm(formula = formula,
                                              data = ccesplus,
                                              weights = ccesplus$cc.commonweight)
  # Probit
  # This will produce a warning about non-integer #successes; it's because of the weights
  formula = as.formula(paste(var, "~", paste(v.x.withfe, collapse = '+')))
  modcces$probit$m[[var]] = glm(formula = formula,
                                                  data = ccesplus,
                                                  family = binomial(link = 'probit'),
                                                  weights = ccesplus$cc.commonweight)
  # Logit
  formula = as.formula(paste(var, "~", paste(v.x.withfe, collapse = '+')))
  modcces$logit$m[[var]] = glm(formula = formula,
                                                 data = ccesplus,
                                                 family = binomial(link = 'logit'),
                                                 weights = ccesplus$cc.commonweight)
  # No FEs
  formula = as.formula(paste(var, "~", paste(v.x.withfe, collapse = '+')))
  modcces$probit.nofe$m[[var]] = glm(formula = formula,
                                                       data = ccesplus,
                                                       family = binomial(link = 'probit'),
                                                       weights = ccesplus$cc.commonweight)
  # No weights
  formula = as.formula(paste(var, "~", paste(v.x.withfe, collapse = '+')))
  modcces$probit.noweights$m[[var]] = glm(formula = formula,
                                                            data = ccesplus,
                                                            family = binomial(link = 'probit'))
  # Feature Scaled
  formula = as.formula(paste(var, "~", paste(v.x.withfe, collapse = '+')))
  modcces$probit.fscaled$m[[var]] = glm(formula = formula,
                                                          data = ccesplus.fscaled,
                                                          family = binomial(link = 'probit'),
                                                          weights = ccesplus$cc.commonweight)
}

# Print regression results
rmarkdown::render(input = paste0(respath, 'reg1.Rmd'),
                  output_file = paste0(respath, 'reg1.html'))

# Estimate Marginal Effects
v.y = getReg(2.1, regdir.good)$v.y
v.x = getReg(2.1, regdir.good)$v.x
v.x.withfe = c(v.x, fenames.cnty)
statemiss = c('AK', 'CO', 'DC', 'KS', 'ME', 'MN', 'ND', 'WY')
t = paste0('stateabr_', statemiss)
v.x.withfe = setdiff(v.x.withfe, t)
t = main[, v.x.withfe, with = F]
cnty_means = summarize_all(t, mean, na.rm = T)
main.fscaled = as.data.table(main.fscaled)
t = main.fscaled[, v.x.withfe, with = F]
cnty.fscaled_means = summarize_all(t, mean, na.rm = T)

system.time({
    for (var in v.y) {
        modcnty$ols$mam[[var]] = margins(modcnty$ols$m[[var]], data = cnty_means)
        modcnty$ols.fscaled$mam[[var]] = margins(modcnty$ols.fscaled$m[[var]], data = cnty.fscaled_means)
        # these take a while:
        # modcnty$ols$ame[[var]] = margins(modcnty$ols$m[[var]], variables = v.x.withfe)
        # modcnty$ols.fscaled$ame[[var]] = margins(modcnty$ols.fscaled$m[[var]], variables = v.x.withfe)
    }
})

v.y = getReg(1.1,regdir.good)$v.y
v.x = getReg(1.1, regdir.good)$v.x
v.x.withfe = c(v.x, fenames.cces)
t = ccesplus[,v.x.withfe,with=F]
ccesplus_means = summarize_all(t, mean, na.rm = T)
ccesplus.fscaled = as.data.table(ccesplus.fscaled)
t = ccesplus.fscaled[, v.x.withfe, with = F]
ccesplus.fscaled_means = summarize_all(t, mean, na.rm = T)

system.time({
for (var in v.y) {
    # modcces$probit$mam[[var]] = margins(modcces$probit$m[[var]], data = ccesplus_means)
    modcces$probit.fscaled$mam[[var]] = margins(modcces$probit.fscaled$m[[var]], data = ccesplus.fscaled_means)
    # These take a long time:
    # modcces$probit$ame[[var]] = margins(modcces$probit$m[[var]],variables=v.x.withfe)
    modcces$probit.fscaled$ame[[var]] = margins(modcces$probit.fscaled$m[[var]],variables=v.x.withfe)
}
})

save(modcces, modcnty, file = 'regdata.Rdata')
