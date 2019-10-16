# total effect calculator
setproj(10)
loadmain()
#nstallif(c('mlogit','nnet'))
load('regdata.Rdata')


# Functions
ge.predict = function(mod, ccesdat.mlogit, name) {
    # function to predict results
    #prefix = 'test1'
    #mod = modcces$mlogit.nofe$m
    #ccesdat.mlogit = z
    z.predict = predict(mod, newdata = ccesdat.mlogit) # predict
    #print(z.predict[1])
    z.predict = data.table(z.predict, yhat = max.col(z.predict, 'first') - 1) # get winners
    postest.cces = data.table(model.frame(formula2, data = ccesplus), yhat = z.predict[, yhat]) # merge predictions with estimation data (using formula 2 to also put in some other stuff, like the weights)
    #postest.cces[[paste0(prefix,.vote16]] = z.predict[, yhat]
    # Scale up results
    postest.cces[, vote16.tot := 1]
    postest.cces[yhat == 0, vote16.novote := 1]
    postest.cces[yhat == 1, vote16.gop := 1]
    postest.cces[yhat == 2, vote16.dem := 1]
    postest.cces[yhat >= 3, vote16.oth := 1]
    varlist = c('vote16.tot', 'vote16.gop', 'vote16.dem', 'vote16.oth')
    for (var in varlist) {
        postest.cces[, paste0(var) := get(var) * cc.commonweight_vv_post] # apply weights
    }
    #print(head(postest.cces))
    pred.st.vote = postest.cces[, lapply(.SD, sum, na.rm = T), by = 'statename', .SDcols = varlist] # sum by state
    #print(head(pred.st.vote))
    for (var in c('vote16')) {
        for (party in c('gop', 'dem', 'oth')) {
            pred.st.vote[, paste0(var, '.', party, '.pc') := get(paste0(var, '.', party)) / get(paste0(var, '.tot'))]
        }
    }
    return(select(pred.st.vote, statename, contains('.pc')))
}
ge.predict12 = function(mod, ccesdat.mlogit, name) {
    z.predict = predict(mod, newdata = ccesdat.mlogit) # predict
    z.predict = data.table(z.predict, yhat = max.col(z.predict, 'first') - 1) # get winners
    postest.cces = data.table(model.frame(formula4, data = ccesplus), yhat = z.predict[, yhat]) # merge predictions with estimation data (using 
    postest.cces[, vote12.tot := 1]
    postest.cces[yhat == 0, vote12.novote := 1]
    postest.cces[yhat == 1, vote12.gop := 1]
    postest.cces[yhat == 2, vote12.dem := 1]
    postest.cces[yhat >= 3, vote12.oth := 1]
    varlist = c('vote12.tot', 'vote12.gop', 'vote12.dem', 'vote12.oth')
    for (var in varlist) {
        postest.cces[, paste0(var) := get(var) * cc.commonweight_vv_post] # apply weights
    }
    #print(head(postest.cces))
    pred.st.vote = postest.cces[, lapply(.SD, sum, na.rm = T), by = 'statename', .SDcols = varlist] # sum by state
    #print(head(pred.st.vote))
    for (var in c('vote12')) {
        for (party in c('gop', 'dem', 'oth')) {
            pred.st.vote[, paste0(var, '.', party, '.pc') := get(paste0(var, '.', party)) / get(paste0(var, '.tot'))]
        }
    }
    return(select(pred.st.vote, statename, contains('.pc')))
}


# Fit Models----------
library(mlogit)
library(nnet)
# Train model
regdir.good = data.table(gs_read(gstarget, ws = 'regdir'))
#ccesplus = dummy_cols(ccesplus, select_columns = c('stateabr'), remove_most_frequent_dummy = T)
#fenames.cces = names(select(ccesplus, contains('stateabr_')))
v.y = getReg(3.1, regdir.good)$v.y
v.x = getReg(3.1, regdir.good)$v.x
#v.x.withfe = c(getReg(3.1, regdir.good)$v.x, fenames.cces)

# 2016 elections
ccesplus.mlogit = mlogit.data(ccesplus, shape = 'wide', choice = 'cc.vote16')
formula1 = as.formula(paste(v.y, '~ 0 |', paste(v.x, collapse = '+')))
formula2 = as.formula(paste(v.y, '~', paste(v.x, collapse = '+'), '+statename', '+statefips', '+cc.commonweight_vv_post'))
ccesplus.small = as.data.table(model.frame(formula2, data = ccesplus))
system.time({ modcces$mlogit.nofe$m = mlogit(formula = formula1, data = ccesplus.mlogit) })

# 2012 elections
ccesplus.mlogit2 = mlogit.data(ccesplus, shape = 'wide', choice = 'cc.vote12')
v.y = 'cc.vote12'
formula3 = as.formula(paste(v.y, '~ 0 |', paste(v.x, collapse = '+')))
formula4 = as.formula(paste(v.y, '~', paste(v.x, collapse = '+'), '+statename', '+statefips', '+cc.commonweight_vv_post'))
ccesplus.small2 = as.data.table(model.frame(formula4, data = ccesplus))
system.time({ modcces$mlogit.nofe2$m = mlogit(formula = formula3, data = ccesplus.mlogit2) })


#system.time({ mod$nlogit.nofe$m = mlogit(formula = formula1, data = tester, nests = list( other = c('1','2','3', '4', '5', '6'))) })
# Evaluate Model Fit
#mean(postest.cces$yhat.cc.vote16 == postest.cces$cc.vote16)
#MSE(postest.cces$yhat.cc.vote16, postest.cces$cc.vote16)

# Get list of relevant variables -------------
estout=list()
regdir.good = data.table(gs_read(gstarget, ws = 'regdir'))
regdir = getReg(1.1, regdir.good)$dir
for (var in getReg(1.1, regdir.good)$v.y[1]) {
        #var = getReg(1.1, regdir.good)$v.y[1]
        #margtype = 'mam'
        t = summary(modcces$logit.fscaled[['mam']][[var]])[, c('factor', 'AME', 'p')]
        estout[[var]] = merge(regdir[, .(varname.raw, varname.print, table.cat)], t,
          by.x = 'varname.raw', by.y = 'factor')
    }
varlist = estout$cc.TrumpGEVote[abs(p)<=0.05,.(varname.raw,varname.print)]

# Preform tot effect analysis -------------
# Create permuted datasets
ccesperm = list()
ccesperm$base = copy(ccesplus.small)
for (var in varlist$varname.raw) {
    ccesperm[[var]] = copy(ccesplus.small)
    ccesperm[[var]][,paste(var) := 0]
}


ccesperm2 = list()
ccesperm2$base = copy(ccesplus.small2)
for (var in varlist$varname.raw) {
    ccesperm2[[var]] = copy(ccesplus.small2)
    ccesperm2[[var]][, paste(var) := 0]
}

# loop over permutations
# 2016
load(file = 'stvote.Rdata')
for (perm in names(ccesperm)) {
    #for (perm in 'all.racist') {
    print(perm)
    z = mlogit.data(ccesperm[[perm]], shape = 'wide', choice = 'cc.vote16')
    st.vote[[perm]] = list()
    st.vote[[perm]]$dat = ge.predict(modcces$mlogit.nofe$m, z, 'perm')
}
save(st.vote, file = 'stvotepost16.Rdata')

# 2012
load(file = 'stvote.Rdata')
st.vote12 = st.vote
for (perm in names(ccesperm2)) {
    #for (perm in 'all.racist') {
    print(perm)
    z = mlogit.data(ccesperm2[[perm]], shape = 'wide', choice = 'cc.vote12')
    st.vote12[[perm]] = list()
    st.vote12[[perm]]$dat = ge.predict12(modcces$mlogit.nofe2$m, z, 'perm')
}
save(st.vote12, file = 'stvotepost12.Rdata')


load(file = 'elecvotes.Rdata')
load(file = 'stvotepost.Rdata')
load(file = 'stvotepost12.Rdata')

for (elec in names(st.vote)) {
    #elec = names(st.vote)[3]
    st.vote[[elec]]$dat$winner = max.col(st.vote[[elec]]$dat[, 2:ncol(st.vote[[elec]]$dat)], 'first')
    st.vote[[elec]]$dat$winner = mapvalues(st.vote[[elec]]$dat$winner, c(1, 2, 3), c('gop', 'dem', 'oth'))
    st.vote[[elec]]$dat = merge(st.vote[[elec]]$dat, elecvotes)
    st.vote[[elec]]$dat$gop.pmarg = st.vote[[elec]]$dat$vote16.gop.pc - st.vote[[elec]]$dat$vote16.dem.pc
    st.vote[[elec]]$dat$gop.win = 0
    st.vote[[elec]]$dat$gop.win[st.vote[[elec]]$dat$gop.pmarg > 0] = 1
    print('jomama')
    st.vote[[elec]]$gopvotes = st.vote[[elec]]$dat[gop.win==1, sum(evotes)]
    #st.vote[[elec]]$tallystr = paste('GOP:', st.vote[[elec]]$tally[winner == 'gop', 2], 'Dem:', st.vote[[elec]]$tally[winner == 'dem', 2])
}

for (elec in names(st.vote12)) {
    #elec = names(st.vote12)[3]
    st.vote12[[elec]]$dat$winner = max.col(st.vote12[[elec]]$dat[, 2:ncol(st.vote12[[elec]]$dat)], 'first')
    st.vote12[[elec]]$dat$winner = mapvalues(st.vote12[[elec]]$dat$winner, c(1, 2, 3), c('gop', 'dem', 'oth'))
    st.vote12[[elec]]$dat = merge(st.vote12[[elec]]$dat, elecvotes)
    st.vote12[[elec]]$dat$gop.pmarg = st.vote12[[elec]]$dat$vote12.gop.pc - st.vote12[[elec]]$dat$vote12.dem.pc
    st.vote12[[elec]]$dat$gop.win = 0
    st.vote12[[elec]]$dat$gop.win[st.vote12[[elec]]$dat$gop.pmarg > 0] = 1
    st.vote12[[elec]]$gopvotes = st.vote12[[elec]]$dat[gop.win == 1, sum(evotes)]
    #st.vote12[[elec]]$tallystr = paste('GOP:', st.vote12[[elec]]$tally[winner == 'gop', 2], 'Dem:', st.vote12[[elec]]$tally[winner == 'dem', 2])
}


toteffect = data.frame(var=character(),gop16=numeric(),gop12=numeric(),stringsAsFactors = F)
for (i in 1:length(st.vote)) {
    #toteffect[i,] = list('c', 1, 2)
    toteffect[i,] = list(names(st.vote)[i], st.vote[[i]]$gopvotes, st.vote12[[i]]$gopvotes)
}

toteffect = as.data.table(toteffect)
toteffect[, diff16 := gop16 - toteffect[var == 'base']$gop16]
toteffect[, diff12 := gop12 - toteffect[var == 'base']$gop12]

toteffect[, diffabs16 := abs(diff16)]
toteffect[, diffabs12 := abs(diff12)]

toteffect = toteffect[4:nrow(toteffect)]

toteffect = merge(toteffect, varlist, by.x = 'var', by.y = 'varname.raw', all.x = T)
setcolorder(toteffect, c('var', 'varname.print'))

gs_edit_cells(ss = gsresults, ws = 'toteffectraw', input = toteffect, anchor = "A1", trim = T, verbose = F)
