# Globals
#setproj(10)
#loadmain()
#install.packages('margins')
library(margins)

# Functions
getreg = function(regdir) {
    regobj = list()
    vartablenames = names(regdir)
    # Prep reg0, the baseline regression
    regobj$reg0 = list()
    regobj$reg0$xtable = regdir[regid1 == 0 & info == 'x' & is.na(exclude)]
    regitem.other = c('y', 'conditions', 'dtname', 'xaddendum', 'est.switch', 'postest.switch')
    for (item in regitem.other) {
        regobj$reg0[[item]] = regdir[regid1 == 0 & info == item, commands]
    }
    nreg = max(unique(regdir$regid1), na.rm = T)
    if (nreg == 0) {
        # Allows regid = 0 only
        nreg = length(unique(regdir$regid1))
        names(regobj$regs) = as.character(unique(na.omit(regdir$regname.print)))
    } else {
        # If there's more than one reg, regid = 0 becomes "silent"
        regobj$regs = vector('list', length = nreg)
        names(regobj$regs) = as.character(unique(na.omit(regdir[regid1 > 0, regname.print])))
    }
    regobj$meta = NULL
    for (i in 1:nreg) {
        # Main loop
        #i = 1
        # 1. Add to regobj$reg0$xtable with new values to form reg1, reg2, etc, or remove if exclude==1
        z = merge(regobj$reg0$xtable, regdir[regid1 == i & (info == 'x')],
            by = c('xname.raw'), suffixes = c('.old', ''), all = T) # 1. For xtable
        for (var in setdiff(vartablenames, c('regid1','regid2','xname.raw'))) { # update values in xtable xtable
            z[is.na(get(var)), paste0(var) := get(paste0(var, '.old'))]
        }
        regobj$regs[[i]]$xtable = select(z, - contains('.old'))[is.na(exclude)]
        # 2. Do the same for other regression objects
        for (item in regitem.other) {
            regobj$regs[[i]][[item]] = union(regobj$reg0[[item]], regdir[regid1 == i & info == item & is.na(exclude), commands])
            regobj$regs[[i]][[item]] = setdiff(regobj$regs[[i]][[item]], regdir[regid1 == i & info == item & exclude == 1, commands])
        }
        # 3. Process xaddendum and formula
        xaddendum = tryCatch(eval(parse(text = regobj$regs[[i]]$xaddendum)),
            error = function(e) return(regobj$regs[[i]]$xaddendum))
        regobj$regs[[i]]$formula.str = paste0(regobj$regs[[i]]$y, '~',
            paste(regobj$regs[[i]]$xtable$xname.raw, collapse = '+'),
            ifelse(length(xaddendum) == 0, '', paste0('+', xaddendum))
        )
        # Write metadata
        z = data.table(regid = i, regname.print = names(regobj$regs)[i], t(regobj$regs[[i]][2:length(regobj$regs[[i]])]))
        regobj$meta = rbind(z, regobj$meta)
    }
    regobj$meta = regobj$meta[order(regid)]
    regobj$meta[is.na(regname.print),regname.print := regid]
    return(regobj)
}

postest.ame = function(mod) {
    #mod = modobj$models[[1]]
    # establish means
    data = as.data.table(mod$model)
    isdum = sapply(data, function(x) { all(x %in% c(0:1, NA)) })
    dt.mean.0 = data[, lapply(.SD, mean, na.rm = TRUE)]
    ame = numeric()
    for (x in names(mod$model)[2:length(mod$model)]) {

        #x = names(mod$model)[2:length(mod$model)][1]
        if (isdum[x]) {
        #if (1==2) {
            #print(paste(x,' is dum'))
            dt.mean.0.dum = copy(dt.mean.0)
            dt.mean.0.dum[[x]] = 0
            dt.mean.1.dum = copy(dt.mean.0)
            dt.mean.1.dum[[x]] = 1
            ame[[x]] = predict(mod, newdata = dt.mean.1.dum, type = 'response') - predict(mod, newdata = dt.mean.0.dum, type = 'response')
        } else {
            #print(paste(x, ' is not dum'))
            dt.mean.1 = copy(dt.mean.0);
            dt.mean.1[[x]] = dt.mean.1[[x]] + 1;
            ame[[x]] = predict(mod, newdata = dt.mean.1, type = 'response') - predict(mod, newdata = dt.mean.0, type = 'response')
        }
    }
    return(data.table(factor = names(ame), myame = ame))
}

estreg = function(regobj, postest = F) {
    nreg = length(regobj$regs)
    mod = list()
    mod$meta = regobj$meta
    # Estimation
    for (i in 1:nreg) {
        print(names(regobj$regs[i]))
        # Apply conditions
        if (length(regobj$regs[[i]]$conditions) == 0) {
            regdata = get(regobj$regs[[i]]$dtname)
        } else {
          #regdata = get(regobj$regs[[i]]$dtname)[eval(parse(text = regobj$regs[[i]]$conditions)),]
          regdata = get(regobj$regs[[i]]$dtname)[eval(parse(text = paste('(',regdir.cces[["meta"]]$conditions[[i]],')',collapse='&'))),]
        }
        # Run models based on est.switch
        if ('ols' %in% regobj$regs[[i]]$est.switch) {
            mod$models[[i]] = lm(formula = as.formula(regobj$regs[[i]]$formula.str), data = regdata)
        }
        if ('logit' %in% regobj$regs[[i]]$est.switch) {
            mod$models[[i]] = glm(formula = as.formula(regobj$regs[[i]]$formula.str), data = regdata,
            family = binomial(link = 'logit'))
        }
        if (1 == 0) {
            #statement3
        }
    }
    names(mod$models)=regobj$meta$regname.print
    if (postest == F) { return(mod) }
    # Post-estimation
    for (i in 1:nreg) {
        # Apply conditions
        #if (length(regobj$regs[[i]]$conditions) == 0) {
        #regdata = get(regobj$regs[[i]]$dtname)
        #} else {
        #regdata = get(regobj$regs[[i]]$dtname)[eval(parse(text = regobj$regs[[i]]$conditions)),]
        #}
        # Run models based on postest.switch
        if ('ame' %in% regobj$regs[[i]]$postest.switch) {

            mod$postest$ame[[i]] = postest.ame(mod$models[[i]])
            #[[i]] = lm(formula = as.formula(regobj$regs[[i]]$formula.str), data = regdata)
        }

        if ('margins' %in% regobj$regs[[i]]$postest.switch) {
            z = as.data.table(mod$models[[i]]$model)[, lapply(.SD, mean, na.rm = TRUE)]
            #print(z)
            mod$postest$mem[[i]] = summary(margins(mod$models[[i]], data = z, vce = 'delta')) # margins
            mod$postest$mem[[i]] = margin.star(mod$postest$mem[[i]])
        }
    }
    #names(mod$postest$ame) = regobj$meta$regname.print
    #names(mod$postest$mem) = regobj$meta$regname.print
    return(mod)
}

margin.star = function(margins.sum) {
    margins.sum = as.data.table(margins.sum)
    margins.sum[, amestar := '']
    margins.sum[p <= 0.05, amestar := '*']
    margins.sum[p <= 0.01, amestar := '**']
    margins.sum[p <= 0.001, amestar := '***']
    margins.sum[, AMEstr := paste0('\'', round(AME, 3), amestar)]
    return(margins.sum)
}
postestToLong = function(postest.obj, meta) {
    z = list()
    for (i in 1:length(postest.obj)) {
        #print(postest.obj[[i]])
        z[[i]] = tableToLong(postest.obj[[i]])
        #print(z[[i]])
    }
    z = do.call(rbind, z)
    z = merge(z, meta[, regid, regname.print], by.x = 'regid1', by.y = 'regid', all.x = T)
    z[, info := paste0(regname.print, '.', variable)]
    # dump
}

tableToLong = function(mod.postest) {
    z = list()
    for (i in 1:length(mod.postest)) {
        z[[i]] = melt(as.data.table(mod.postest[[i]]), id.vars = 1)
        z[[i]][, regid1 := i]
    }
    return(do.call(rbind, z))
}

getKeithAme = function() {
    names = c('factor','trump.ge.rf', 'trump.pri.rf', 'romney.ge.rf')
    z1 = fread('https://raw.githubusercontent.com/kperkins411/VoterAnalysis/master/outBElectionResultsScaled2/MEMS_cc.TrumpGEVote.csv')[, c(2,8)]
    z2 = fread('https://raw.githubusercontent.com/kperkins411/VoterAnalysis/master/outBElectionResultsScaled2/MEMS_cc.TrumpPVote.csv')[, 8]
    z3 = fread('https://raw.githubusercontent.com/kperkins411/VoterAnalysis/master/outBElectionResultsScaled2/MEMS_cc.vote12.gop.csv')[, 8]
    z = data.table(z1, z2, z3)
    names(z) = names
    return(z)
}

# Estimation/Postestimation
reg.gs = gs_key('1nkHccv2nu4O2WFp2eHfqzPolqiG8y8n4pzhb0-RfTTI')
regdir = data.table(gs_read(reg.gs, ws = 'regdir2'))
regdir = regdir[regid2 == 1] #regid2 == 1]


regdir.cces = getreg(regdir)
est.cces = estreg(regdir.cces, postest = T)

# Create gsheets output
z = postestToLong(est.cces$postest, est.cces$meta)
ame.out = data.table::dcast(z[variable %in% c('AME')], factor ~ info)
#ame.out = data.table::dcast(z[variable %in% c('myame', 'AME', 'p')], factor ~ info)
#ame.out = merge(ame.out, getKeithAme())
lookup = regdir.cces$regs[[1]]$xtable[, .(xname.raw, xname.print,xtable.section)]


ame.out = merge(ame.out, lookup, by.x = 'factor', by.y='xname.raw',all=T)
setcolorder(ame.out, c('factor', 'xname.print','xtable.section'))
#setcolorder(ame.out, c('factor', 'xname.print','xtable.section', paste0(est.cces$meta$regname.print, '.AME')))
#z = names(select(ame.out,-factor,-contains('logit.p')))
#z = c('factor',rev(sort(z)),names(select(ame.out,contains('logit.p'))))
#setcolorder(ame.out, neworder = z)
ame.out = ame.out[order(xtable.section,factor)]
gs_edit_cells(ss = reg.gs, ws = 'postest 1', input = ame.out, anchor = "A1", trim = T, verbose = F)



#stats::xtabs(formula =  ~ ccesplus$cc.RepDum+ccesplus$cc.TrumpGEVote, data = ccesplus)
#stats::xtabs(formula = ~ccesplus$cc.DemDum + ccesplus$cc.TrumpGEVote, data = ccesplus)
#stats::xtabs(formula = ~ccesplus$cc.IndDum + ccesplus$cc.TrumpGEVote, data = ccesplus)
#stats::xtabs(formula = ~ccesplus$cc.IndDum + ccesplus$cc.RepDum, data = ccesplus)

# State FEs
#ccesplus = dummy_cols(ccesplus, select_columns = c('stateabr'), remove_most_frequent_dummy = T)
#ccesplus.fscaled = dummy_cols(ccesplus.fscaled, select_columns = c('stateabr'), remove_most_frequent_dummy = T)
#fenames.cces = names(select(ccesplus, contains('stateabr_')))

#main = dummy_cols(main, select_columns = c('stateabr'), remove_most_frequent_dummy = T)
#main.fscaled = dummy_cols(main.fscaled, select_columns = c('stateabr'), remove_most_frequent_dummy = T)
#fenames.cnty = names(select(main, contains('stateabr_')))





## CCES Regressions
#ccesplus_means = summarize_all(ccesplus[, getReg(1.1, regdir.good)$v.x, with = F], mean, na.rm = T)
#ccesplus.fscaled_means = summarize_all(ccesplus.fscaled[, getReg(1.1, regdir.good)$v.x, with = F], mean, na.rm = T)

#modcces = list()
#for (var in getReg(1.1, regdir.good)$v.y) {
    #print(var)
    ## OLS
    #formula = as.formula(paste(var, "~", paste(getReg(1.1, regdir.good)$v.x, collapse = '+')))
    #modcces$ols$m[[var]] = lm(formula = formula, data = ccesplus, weights = ccesplus$cc.commonweight)
    ## Probit - This will produce a warning about non-integer #successes; it's because of the weights
    #formula = as.formula(paste(var, "~", paste(getReg(1.1, regdir.good)$v.x, collapse = '+')))
    #modcces$probit$m[[var]] = glm(formula = formula, data = ccesplus, family = binomial(link = 'probit'), weights = ccesplus$cc.commonweight)
    ## Logit
    #formula = as.formula(paste(var, "~", paste(getReg(1.1, regdir.good)$v.x, collapse = '+')))
    #modcces$logit$m[[var]] = glm(formula = formula, data = ccesplus, family = binomial(link = 'logit'), weights = ccesplus$cc.commonweight)
    ## Logit, No weights
    #formula = as.formula(paste(var, "~", paste(getReg(1.1, regdir.good)$v.x, collapse = '+')))
    #modcces$probit.noweights$m[[var]] = glm(formula = formula, data = ccesplus, family = binomial(link = 'logit'))
    ## Logit, fscaled
    #formula = as.formula(paste(var, "~", paste(getReg(1.1, regdir.good)$v.x, collapse = '+')))
    #modcces$logit.fscaled$m[[var]] = glm(formula = formula, data = ccesplus.fscaled, family = binomial(link = 'logit'),
                                         #weights = ccesplus$cc.commonweight)
    #modcces$logit.fscaled$mam[[var]] = margins(modcces$logit.fscaled$m[[var]], data = ccesplus.fscaled_means, vce = 'delta') # margins

  ## Logit, fscaled, compare college vs. non-college whites (use regdir = 2.1)
    #formula = as.formula(paste(var, "~", paste(getReg(1.2, regdir.good)$v.x, collapse = '+')))
    #modcces$logit.fscaled.whiteNoBS$m[[var]] = glm(formula = formula, data = ccesplus.fscaled[cc.WhiteDum==1&cc.maxeduc.hs==1],
        #family = binomial(link = 'logit'), weights = ccesplus[cc.WhiteDum == 1 & cc.maxeduc.hs == 1]$cc.commonweight)
    #modcces$logit.fscaled.whiteNoBS$mam[[var]] = margins(modcces$logit.fscaled.whiteNoBS$m[[var]], data = ccesplus.fscaled_means, vce = 'delta')

    #formula = as.formula(paste(var, "~", paste(getReg(1.2, regdir.good)$v.x, collapse = '+')))
    #modcces$logit.fscaled.whiteHasBS$m[[var]] = glm(formula = formula, data = ccesplus.fscaled[cc.WhiteDum == 1 & cc.maxeduc.4yr == 1],
        #family = binomial(link = 'logit'), weights = ccesplus[cc.WhiteDum == 1 & cc.maxeduc.4yr == 1]$cc.commonweight)
    #modcces$logit.fscaled.whiteHasBS$mam[[var]] = margins(modcces$logit.fscaled.whiteHasBS$m[[var]], data = ccesplus.fscaled_means, vce = 'delta')
#}

# Logit response graphs
#formula = as.formula(paste('cc.TrumpGEVote', "~", paste(getReg(1.1, regdir.good)$v.x, collapse = '+')))
#mod = glm(formula = formula, data = as.data.frame(ccesplus), family = binomial(link = 'logit'), weights = ccesplus$cc.commonweight)
#cplot(mod,'cc.raceviewsum',what='effect')




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
