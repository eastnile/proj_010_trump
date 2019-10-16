getReg = function(regid.arg, regdir.arg) {

    t = regdir.arg[regid == regid.arg]
    t = t[order(table.order1, table.order2)]
    v.x = t[include != 'y']$varname.raw
    v.y = t[include == 'y']$varname.raw
    xlabels = t[include != 'y']$varname.print
    # regdata = as.data.frame(ccesplus[, c(v.x.withfe, v.y), with = F])
    reg = list()
    reg$formula = as.formula(paste(v.y, "~", paste(v.x, collapse = '+')))
    reg$v.x = v.x
    reg$v.y = v.y
    return(reg)
}

gsdat = data.table(gs_read(codebook.gs, ws = 'regdir'))
regdir = gsdat[!is.na(include) & is.na(exclude), .(regid, regdscr, varname.raw, varname.print, table.cat, table.order1, table.order2, exclude, include, flag1, flag2)]

# Feature Scaling
isdum = sapply(ccesplus, function(x) { all(x %in% c(0:1, NA)) })
isnumeric = sapply(ccesplus, is.numeric)
norescale = isdum | !isnumeric
t = as.data.frame(ccesplus)
ccesplus.fscaled = as.data.frame(ccesplus)
ccesplus.fscaled[!norescale] = scale(t[!norescale])

mod = list()
for (regid in c(1.1, 1.2)) {
    # OLS
      formula = getReg(regid, regdir)$formula
    mod$ols$m[[getReg(regid, regdir)$v.y]] = lm(formula = formula,
                                                    data = ccesplus,
                                                    weights = ccesplus$cc.commonweight)
    # Probit
    # This will produce a warning about non-integer #successes; it's because of the weights
    formula = getReg(regid, regdir)$formula
    mod$probit$m[[getReg(regid, regdir)$v.y]] = glm(formula = formula,
                                                 data = ccesplus,
                                                 family = binomial(link = 'probit'),
                                                 weights = ccesplus$cc.commonweight)
    # Logit
    formula = getReg(regid, regdir)$formula
    mod$logit$m[[getReg(regid, regdir)$v.y]] = glm(formula = formula,
                                                    data = ccesplus,
                                                    family = binomial(link = 'logit'),
                                                    weights = ccesplus$cc.commonweight)
    # No FEs
    formula = getReg(regid, regdir)$formula
    mod$probit.nofe$m[[getReg(regid, regdir)$v.y]] = glm(formula = formula,
                                                         data = ccesplus,
                                                         family = binomial(link = 'probit'),
                                                         weights = ccesplus$cc.commonweight)
    # No weights
    formula = getReg(regid, regdir)$formula
    mod$probit.noweights$m[[getReg(regid, regdir)$v.y]] = glm(formula = formula,
                                                 data = ccesplus,
                                                 family = binomial(link = 'probit'))
    # Feature Scaled
    formula = getReg(regid, regdir)$formula
    mod$probit.fscaled$m[[getReg(regid, regdir)$v.y]] = glm(formula = formula,
                                                 data = ccesplus.fscaled,
                                                 family = binomial(link = 'probit'),
                                                 weights = ccesplus$cc.commonweight)
}
require(rmarkdown)
rmarkdown::render(input = paste0(respath, 'regout_cces.Rmd'),
          output_file = paste0(respath, 'regout.html'))


#for (var in v.y) {
    #var = 'cc.TrumpGEVote'
    ### With State FEs
    ## OLS
    #formula = getFormula(1.1, regdir)
    #mod$ols$m[[var]] = lm(formula = formula, data = ccesplus, weights = ccesplus$cc.commonweight)
    ## Probit
    #formula = as.formula(paste(var, "~", paste(v.x.withfe, collapse = '+')))
    #mod$probit$m[[var]] = glm(formula = formula, data = regdata, family = binomial(link = 'probit'), weights = ccesplus$cc.commonweight)
    ## Logit
    #formula = as.formula(paste(var, "~", paste(v.x.withfe, collapse = '+')))
    #mod$logit$m[[var]] = glm(formula = formula, data = regdata, family = binomial(link = 'logit'), weights = ccesplus$cc.commonweight)
    ## No FEs
    #formula = as.formula(paste(var, "~", paste(v.x, collapse = '+')))
    #mod$probit.nofe$m[[var]] = glm(formula = formula, data = regdata, family = binomial(link = 'probit'), weights = ccesplus$cc.commonweight)
    ## No weights
    #formula = as.formula(paste(var, "~", paste(v.x.withfe, collapse = '+')))
    #mod$probit.noweight$m[[var]] = glm(formula = formula, data = regdata, family = binomial(link = 'probit'))
    ## Feature Scaled
    ## No weights
    #formula = as.formula(paste(var, "~", paste(v.x.withfe, collapse = '+')))
    #mod$probit.fscaled$m[[var]] = glm(formula = formula, data = regdata.fscaled, family = binomial(link = 'probit'), weights = ccesplus$cc.commonweight)
#}
