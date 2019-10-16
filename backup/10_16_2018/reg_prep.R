setproj(10)
loadmain()


# Get regression variables
gsdat = data.table(gs_read(gs_key(gsKey),ws='ccesplus guide'))
reg.guide = gsdat[!is.na(include)&is.na(omit.dummy)&is.na(exclude),.(varname.raw,tags,include)]



v.x.suffer = reg.guide[include=='suffer']$varname.raw
v.x.relig = reg.guide[include=='relig']$varname.raw
v.x.race = reg.guide[include=='race']$varname.raw
v.x.mig = reg.guide[include=='mig']$varname.raw
v.x.econ = reg.guide[include=='econ']$varname.raw
v.x.control = reg.guide[include=='control']$varname.raw
v.x.xnoctrl = reg.guide[include!='control']$varname.raw
v.x = reg.guide[include!='y']$varname.raw
v.y = reg.guide[include=='y']$varname.raw

#Set up Dummies
require(fastDummies)
stdum = dummy_cols(ccesplus$stateabr,remove_first_dummy=T)
ccesplus = as.data.table(cbind(ccesplus,stdum))
v.x.dum = names(select(stdum,matches('.data_')))
v.x = c(v.x,v.x.dum)

# Generate regression equations
mod = list()
mod$ols$f = list()
mod$ols$m = list()
mod$ols$r = list()
mod$ols$stata = list()

mod$probit$f = list()
mod$probit$m = list()

mod$logit$f = list()
mod$logit$m = list()

# Run regressions
for (var in v.y) {
   #var = 'cc.TrumpGEVote'
   mod$ols$f[[var]] = as.formula(paste(var,"~",paste(v.x,collapse='+')))
   # mod$ols$stata[[var]] = paste(var,' ',paste(v.x,collapse=''))
   # Dummy line to get stargazer to properly display dependent variable names
   formula = mod$ols$f[[var]]
   #mod$ols$m[[var]] = plm(formula,main,model='within',index='statefipsn')   
   mod$ols$m[[var]] = lm(formula,ccesplus)   
   #mod$ols$m[[var]] = lm(formula,main)
   
   mod$probit$f[[var]] = as.formula(paste(var,"~",paste(v.x,collapse='+')))
   formula = mod$probit$f[[var]]
   mod$probit$m[[var]] = glm(formula = formula,data=ccesplus,family = binomial(link='probit'))   
   
   
   mod$logit$f[[var]] = as.formula(paste(var,"~",paste(v.x,collapse='+')))
   formula = mod$logit$f[[var]]
   mod$logit$m[[var]] = glm(formula = formula,data=ccesplus,family = binomial(link='logit'))  
}

# require(plm)
# for (var in v.y) {
#    mod$ols$f[[var]] = as.formula(paste(var,"~",paste(v.x,collapse='+')))
#    # Dummy line to get stargazer to properly display dependent variable names
#    formula = mod$ols$f[[var]]
#    #mod$ols$m[[var]] = plm(formula,main,model='within',index='statefipsn')   
#    mod$ols$m[[var]] = plm(formula,ccesplus,model='within',index='statefipsn')   
#     #mod$ols$m[[var]] = lm(formula,main)   
# }

#summary(mod$ols$m$cc.TrumpGEVote)

# t.text = 'hello world'
