# Globals
setproj(10)
regdir.good = data.table(gs_read(gstarget, ws = 'regdir'))
loadmain()


# State FEs
#ccesplus = dummy_cols(ccesplus, select_columns = c('stateabr'), remove_most_frequent_dummy = T)
#ccesplus.fscaled = dummy_cols(ccesplus.fscaled, select_columns = c('stateabr'), remove_most_frequent_dummy = T)
#fenames.cces = names(select(ccesplus, contains('stateabr_')))

main = dummy_cols(main, select_columns = c('stateabr'), remove_most_frequent_dummy = T)
main.fscaled = dummy_cols(main.fscaled, select_columns = c('stateabr'), remove_most_frequent_dummy = T)
fenames.cnty = names(select(main, contains('stateabr_')))

# County Level Regressions
v.y = getReg(2.1, regdir.good)$v.y
v.x.withfe = c(getReg(2.1, regdir.good)$v.x, fenames.cnty)
statemiss = paste0('stateabr_',c('AK', 'CO', 'DC', 'KS', 'ME', 'MN', 'ND', 'WY'))
v.x.withfe = setdiff(v.x.withfe, t) # drop missing states

cnty_means = summarize_all(main[, v.x.withfe, with = F], mean, na.rm = T)
cnty.fscaled_means = summarize_all(main.fscaled[, v.x.withfe, with = F], mean, na.rm = T)

modcnty = list()
for (var in v.y) {
    # OLS
    print(v.y)
    formula = as.formula(paste(var, "~", paste(v.x.withfe, collapse = '+')))
    modcnty$ols$m[[var]] = lm(formula = formula, data = main)

    # Feature Scaled
    formula = as.formula(paste(var, "~", paste(v.x.withfe, collapse = '+')))
    modcnty$ols.fscaled$m[[var]] = lm(formula = formula, data = main.fscaled)
    modcnty$ols.fscaled$mam[[var]] = margins(modcnty$ols.fscaled$m[[var]], data = cnty.fscaled_means, vce = 'delta') # Marg
    # modcnty$ols$ame[[var]] = margins(modcnty$ols$m[[var]], variables = v.x.withfe)
    # modcnty$ols.fscaled$ame[[var]] = margins(modcnty$ols.fscaled$m[[var]], variables = v.x.withfe)
}

# CCES Regressions
ccesplus_means = summarize_all(ccesplus[, getReg(1.1, regdir.good)$v.x, with = F], mean, na.rm = T)
ccesplus.fscaled_means = summarize_all(ccesplus.fscaled[, getReg(1.1, regdir.good)$v.x, with = F], mean, na.rm = T)

modcces = list()
for (var in getReg(1.1, regdir.good)$v.y) {
    print(var)
    # OLS
    formula = as.formula(paste(var, "~", paste(getReg(1.1, regdir.good)$v.x, collapse = '+')))
    modcces$ols$m[[var]] = lm(formula = formula, data = ccesplus, weights = ccesplus$cc.commonweight)
    # Probit - This will produce a warning about non-integer #successes; it's because of the weights
    formula = as.formula(paste(var, "~", paste(getReg(1.1, regdir.good)$v.x, collapse = '+')))
    modcces$probit$m[[var]] = glm(formula = formula, data = ccesplus, family = binomial(link = 'probit'), weights = ccesplus$cc.commonweight)
    # Logit
    formula = as.formula(paste(var, "~", paste(getReg(1.1, regdir.good)$v.x, collapse = '+')))
    modcces$logit$m[[var]] = glm(formula = formula, data = ccesplus, family = binomial(link = 'logit'), weights = ccesplus$cc.commonweight)
    # Logit, No weights
    formula = as.formula(paste(var, "~", paste(getReg(1.1, regdir.good)$v.x, collapse = '+')))
    modcces$probit.noweights$m[[var]] = glm(formula = formula, data = ccesplus, family = binomial(link = 'logit'))
    # Logit, fscaled
    formula = as.formula(paste(var, "~", paste(getReg(1.1, regdir.good)$v.x, collapse = '+')))
    modcces$logit.fscaled$m[[var]] = glm(formula = formula, data = ccesplus.fscaled, family = binomial(link = 'logit'),
                                         weights = ccesplus$cc.commonweight)
    modcces$logit.fscaled$mam[[var]] = margins(modcces$logit.fscaled$m[[var]], data = ccesplus.fscaled_means, vce = 'delta') # margins

  # Logit, fscaled, compare college vs. non-college whites (use regdir = 2.1)
    formula = as.formula(paste(var, "~", paste(getReg(1.2, regdir.good)$v.x, collapse = '+')))
    modcces$logit.fscaled.whiteNoBS$m[[var]] = glm(formula = formula, data = ccesplus.fscaled[cc.WhiteDum==1&cc.maxeduc.hs==1],
        family = binomial(link = 'logit'), weights = ccesplus[cc.WhiteDum == 1 & cc.maxeduc.hs == 1]$cc.commonweight)
    modcces$logit.fscaled.whiteNoBS$mam[[var]] = margins(modcces$logit.fscaled.whiteNoBS$m[[var]], data = ccesplus.fscaled_means, vce = 'delta')

    formula = as.formula(paste(var, "~", paste(getReg(1.2, regdir.good)$v.x, collapse = '+')))
    modcces$logit.fscaled.whiteHasBS$m[[var]] = glm(formula = formula, data = ccesplus.fscaled[cc.WhiteDum == 1 & cc.maxeduc.4yr == 1],
        family = binomial(link = 'logit'), weights = ccesplus[cc.WhiteDum == 1 & cc.maxeduc.4yr == 1]$cc.commonweight)
    modcces$logit.fscaled.whiteHasBS$mam[[var]] = margins(modcces$logit.fscaled.whiteHasBS$m[[var]], data = ccesplus.fscaled_means, vce = 'delta')
}

# Logit response graphs
formula = as.formula(paste('cc.TrumpGEVote', "~", paste(getReg(1.1, regdir.good)$v.x, collapse = '+')))
mod = glm(formula = formula, data = as.data.frame(ccesplus), family = binomial(link = 'logit'), weights = ccesplus$cc.commonweight)
cplot(mod,'cc.raceviewsum',what='effect')




# Print regression results
# rmarkdown::render(input = paste0(respath, 'reg1.Rmd'),
#                   output_file = paste0(respath, 'reg1.html'))

# Estimate Marginal Effects


#v.y = getReg(1.1,regdir.good)$v.y
#v.x = getReg(1.1, regdir.good)$v.x
#v.x.withfe = c(v.x, fenames.cces)

#system.time({
#for (var in v.y) {
    #print(var)
    ## modcces$probit$mam[[var]] = margins(modcces$probit$m[[var]], data = ccesplus_means)
    #modcces$logit.fscaled$mam[[var]] = margins(modcces$logit.fscaled$m[[var]], data = ccesplus.fscaled_means, vce = 'delta')
    #modcces$logit.fscaled.whiteNoBS$mam[[var]] = margins(modcces$logit.fscaled.whiteNoBS$m[[var]], data = ccesplus.fscaled_means, vce = 'delta')
    #modcces$logit.fscaled.whiteHasBS$mam[[var]] = margins(modcces$logit.fscaled.whiteHasBS$m[[var]], data = ccesplus.fscaled_means, vce = 'delta')


    ## These take a long time:
    ## modcces$probit$ame[[var]] = margins(modcces$probit$m[[var]],variables=v.x.withfe)
    ## modcces$probit.fscaled$ame[[var]] = margins(modcces$probit.fscaled$m[[var]],variables=v.x.withfe)
#}
#})

#save(modcces, modcnty, file = 'regdata.Rdata')
