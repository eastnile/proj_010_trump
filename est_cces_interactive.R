# Fetch regression variables from google sheets
gsgetregvars = function() {
    gsdat = data.table(gs_read(codebook.gs, ws = 'ccesplus guide'))
    return(gsdat[!is.na(include) & is.na(omit.dummy) & is.na(exclude), .(varname.raw, tags, include, description, categories, varname.print, table.cat, table.order1, table.order2)])
}

reg.guide = gsgetregvars()
reg.guide = reg.guide[order(table.order1,table.order2)]
v.x = reg.guide[include!='y']$varname.raw
v.x.withfe = c(v.x,'stateabr')
v.y = reg.guide[include == 'y']$varname.raw
xlabels = reg.guide[include != 'y']$varname.print
regdata = as.data.frame(ccesplus[,c(v.x.withfe,v.y),with=F])

# Run regressions
mod = list()
for (var in v.y) {
    #var = 'cc.TrumpGEVote'
    ## With State FEs
    # OLS
    formula = as.formula(paste(var, "~", paste(v.x.withfe, collapse = '+')))
    mod$ols$m[[var]] = lm(formula = formula, data = regdata, weights = ccesplus$cc.commonweight)
    # Probit
    formula = as.formula(paste(var, "~", paste(v.x.withfe, collapse = '+')))
    mod$probit$m[[var]] = glm(formula = formula, data = regdata, family = binomial(link = 'probit'), weights = ccesplus$cc.commonweight)
    # Logit
    formula = as.formula(paste(var, "~", paste(v.x.withfe, collapse = '+')))
    mod$logit$m[[var]] = glm(formula = formula, data = regdata, family = binomial(link = 'logit'), weights = ccesplus$cc.commonweight)
    # No FEs
    formula = as.formula(paste(var, "~", paste(v.x, collapse = '+')))
    mod$probit.nofe$m[[var]] = glm(formula = formula, data = regdata, family = binomial(link = 'probit'), weights = ccesplus$cc.commonweight)
    # No weights
    formula = as.formula(paste(var, "~", paste(v.x.withfe, collapse = '+')))
    mod$probit.noweight$m[[var]] = glm(formula = formula, data = regdata, family = binomial(link = 'probit'))
    # Feature Scaled
    # No weights
    formula = as.formula(paste(var, "~", paste(v.x.withfe, collapse = '+')))
    mod$probit.fscaled$m[[var]] = glm(formula = formula, data = regdata.fscaled, family = binomial(link = 'probit'), weights = ccesplus$cc.commonweight)
}



# Output:

rmarkdown::render(input = paste0(respath, 'regout_cces.Rmd'),
          output_file = paste0(respath, 'regout.html'))

# OLD CODE:
#Set up Dummies
# stdum = dummy_cols(ccesplus$stateabr,remove_first_dummy=T)
# regdata = as.data.frame(cbind(regdata,stdum))
# regdata.fscaled = as.data.frame(cbind(regdata.fscaled,stdum))
# v.x.dum = names(select(stdum,matches('.data_')))
# v.x.withfe = c(v.x,v.x.dum)


# With state FEs
#mod$ols$m[[var]] = plm(formula,main,model='within',index='statefipsn') 
# require(plm)
# for (var in v.y) {
#    mod$ols$f[[var]] = as.formula(paste(var,"~",paste(v.x,collapse='+')))
#    # Dummy line to get stargazer to properly display dependent variable names
#    formula = mod$ols$f[[var]]
#    #mod$ols$m[[var]] = plm(formula,main,model='within',index='statefipsn')   
#    mod$ols$m[[var]] = plm(formula,ccesplus,model='within',index='statefipsn')   
#     #mod$ols$m[[var]] = lm(formula,main)   
# }