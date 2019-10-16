setproj(10)
loadmain()
load(file = 'stvotepre.Rdata')
load(file = 'regdata.Rdata')
load(file = 'elecvotes.Rdata')
library(choroplethr)

reg.gs = gs_key('1zvWKThk0qleArw62qK4RFSzg8JLz8BAnfZrGxi-yNtg')
reg2 = data.table(gs_read(reg.gs, ws = 'regdir_rerun'))[regid2 == 2 | regid2 == 3] %>% getreg()


# Functions
ge.rerun = function(yhat, name = NULL) {
    # yhat = data.table(model.frame(formula2, data = ccesplus), yhat = yhat[, yhat]) # merge predictions with estimation data (using formula 2 to also put in some other stuff, like the weights)
    #yhat[[paste0(prefix,.vote16]] = yhat[, yhat]
    # Scale up results
    yhat[, vote16.tot := 1]
    yhat[yhat == 0, vote16.novote := 1]
    yhat[yhat == 1, vote16.gop := 1]
    yhat[yhat == 2, vote16.dem := 1]
    yhat[yhat >= 3, vote16.oth := 1]
    varlist = c('vote16.tot', 'vote16.gop', 'vote16.dem', 'vote16.oth')
    for (var in varlist) {
        yhat[, paste0(var) := get(var) * weight] # apply weights
    }
    #print(head(yhat))
    pred.st.vote = yhat[, lapply(.SD, sum, na.rm = T), by = 'statename', .SDcols = varlist] # sum by state
    print(head(pred.st.vote))
    for (var in c('vote16')) {
        for (party in c('gop', 'dem', 'oth')) {
            pred.st.vote[, paste0(var, '.', party, '.pc') := get(paste0(var, '.', party)) / get(paste0(var, '.tot'))]
        }
    }
    return(select(pred.st.vote, statename, contains('.pc')))
}

# Fit Model----------
library(mlogit)
library(nnet)
# Train model
#regdir.good = data.table(gs_read(gstarget, ws = 'regdir'))


#v.y = as.character(unlist(reg2$meta$y))
v.x = reg2$regs[[1]]$xtable$xname.raw
#v.x = getReg(3.1, regdir.good)$v.x

ccesplus.mlogit = mlogit.data(ccesplus, shape = 'wide', choice = 'cc.vote16')
formula1 = as.formula(paste('cc.vote16', '~ 0 |', paste(v.x, collapse = '+')))
formula2 = as.formula(paste('cc.vote16', '~', paste(v.x, collapse = '+'), '+statename', '+statefips', '+cc.commonweight_vv_post')) # for later
ccesplus.small = as.data.table(model.frame(formula2, data = ccesplus))
#formula2 = as.formula(paste(v.y, '~', paste(v.x, collapse = '+'), '+statename', '+statefips', '+cc.commonweight_vv_post')) # for later

system.time({ modcces$mlogit.nofe$m = mlogit(formula = formula1, data = ccesplus.mlogit) })
save(modcces, modcnty, file = 'regdata.Rdata')

##system.time({ mod$nlogit.nofe$m = mlogit(formula = formula1, data = tester, nests = list( other = c('1','2','3', '4', '5', '6'))) })
## Evaluate Model Fit
##mean(postest.cces$yhat.cc.vote16 == postest.cces$cc.vote16)
##MSE(postest.cces$yhat.cc.vote16, postest.cces$cc.vote16)

# permute data --------
ccesperm = list()

ccesperm$e1_allboys = copy(ccesplus.small )
ccesperm$e1_allboys[, cc.Sex := 0]

ccesperm$e1_allgirls = copy(ccesplus.small)
ccesperm$e1_allgirls[, cc.Sex := 1]

ccesperm$e2_allblack = copy(ccesplus.small)
ccesperm$e2_allblack[, cc.BlackDum := 1]
ccesperm$e2_allblack[, cc.WhiteDum := 0]

ccesperm$e2_allwhite = copy(ccesplus.small)
ccesperm$e2_allwhite[, cc.BlackDum := 0]
ccesperm$e2_allwhite[, cc.WhiteDum := 1]

#ccesperm$e3_noeducbs = copy(ccesplus.small)
#ccesperm$e3_noeducbs[, cc.maxeduc.4yr := 0]

#ccesperm$e3_alleducbs = copy(ccesplus.small)
#ccesperm$e3_alleducbs[, cc.maxeduc.4yr := 1]

#ccesperm$e4_ifallwhitesbs = copy(ccesplus.small)
#ccesperm$e4_ifallwhitesbs[cc.WhiteDum == 1, cc.maxeduc.4yr := 1]

#ccesperm$e4_ifnowhitesbs = copy(ccesplus.small)
#ccesperm$e4_ifnowhitesbs[cc.WhiteDum == 1, cc.maxeduc.4yr := 0]

#ccesperm$e5_allracist = copy(ccesplus.small)
#ccesperm$e5_allracist[,cc.raceviewsum := 5]

#ccesperm$e5_noracist = copy(ccesplus.small)
#ccesperm$e5_noracist[, cc.raceviewsum := 1]

#ccesperm$e6_racismlvl1 = copy(ccesplus.small)
#ccesperm$e6_racismlvl1[, cc.raceviewsum := 1]

#ccesperm$e6_racismlvl2 = copy(ccesplus.small)
#ccesperm$e6_racismlvl2[, cc.raceviewsum := 2]

#ccesperm$e6_racismlvl3 = copy(ccesplus.small)
#ccesperm$e6_racismlvl3[, cc.raceviewsum := 3]

#ccesperm$e6_racismlvl4 = copy(ccesplus.small)
#ccesperm$e6_racismlvl4[, cc.raceviewsum := 4]

#ccesperm$e6_racismlvl5 = copy(ccesplus.small)
#ccesperm$e6_racismlvl5[, cc.raceviewsum := 5]

z.descr = c('not_angry', 'no_advantages', 'fear_others', 'racism_rare', 'immviews')
z.vars = c('cc.CC16_422c', 'cc.CC16_422d', 'cc.CC16_422e', 'cc.CC16_422f', 'cc.immviewsum')
for (i in 1:4) {
    for (j in 1:5) {
        ccesperm[[paste0('e3_', z.descr[i], '_lvl', j)]] = copy(ccesplus.small)
        ccesperm[[paste0('e3_', z.descr[i], '_lvl', j)]][, z.vars[i] := j]
    }
}

#ccesperm$e7_nounemp = copy(ccesplus.small)
#ccesperm$e7_nounemp[, cc.emp.nojob := 0]

#ccesperm$e7_allunemp = copy(ccesplus.small)
#ccesperm$e7_allunemp[, cc.emp.nojob := 1]

#ccesperm$e8_allrich = copy(ccesplus.small)
#ccesperm$e8_allrich[, cc.faminc := 10]

#ccesperm$e8_allpoor = copy(ccesplus.small)
#ccesperm$e8_allpoor[, cc.faminc := 2]

library(Hmisc)
z1 = as.double(describe(ccesplus.small$crashpc)$counts[['.90']])
z2 = as.double(describe(ccesplus.small$crashpc)$counts[['.10']])
z3 = as.double(describe(ccesplus.small$crashpc)$counts[['.75']])
z4 = as.double(describe(ccesplus.small$crashpc)$counts[['.25']])
ccesperm$e9_crashpc90 = copy(ccesplus.small)
ccesperm$e9_crashpc90[, crashpc := z1]
ccesperm$e9_crashpc10 = copy(ccesplus.small)
ccesperm$e9_crashpc10[, crashpc := z2]
ccesperm$e9_crashpc75 = copy(ccesplus.small)
ccesperm$e9_crashpc75[, crashpc := z3]
ccesperm$e9_crashpc25 = copy(ccesplus.small)
ccesperm$e9_crashpc25[, crashpc := z4]


z1 = as.double(describe(ccesplus.small$rustpc)$counts[['.90']])
z2 = as.double(describe(ccesplus.small$rustpc)$counts[['.10']])
z3 = as.double(describe(ccesplus.small$rustpc)$counts[['.75']])
z4 = as.double(describe(ccesplus.small$rustpc)$counts[['.25']])
ccesperm$e10_rustpc90 = copy(ccesplus.small)
ccesperm$e10_rustpc90[, rustpc := z1]
ccesperm$e10_rustpc10 = copy(ccesplus.small)
ccesperm$e10_rustpc10[, rustpc := z2]
ccesperm$e10_rustpc75 = copy(ccesplus.small)
ccesperm$e10_rustpc75[, rustpc := z3]
ccesperm$e10_rustpc25 = copy(ccesplus.small)
ccesperm$e10_rustpc25[, rustpc := z4]

# Loop over permutations, predicting votes -----------------

yhats = list()
yhats$logit = list()
yhats$rf = list()
weights.logit = model.frame(formula2, data = ccesplus)$cc.commonweight_vv_post
statename.logit = model.frame(formula2, data = ccesplus)$statename
#origdata.logit = model.frame(formula2, data = ccesplus)

for (perm in names(ccesperm)) {
    print(perm)
    z = mlogit.data(ccesperm[[perm]], shape = 'wide', choice = 'cc.vote16')
    z = predict(modcces$mlogit.nofe$m, newdata = z)
    z = data.table(yhat = max.col(z, 'first') - 1) # collect winners
    yhats$logit[[perm]] = data.table(z, weight = weights.logit, statename = statename.logit)
    }

keithdata = fread('https://raw.githubusercontent.com/kperkins411/VoterAnalysis/master/outBElectionResultsScaled2/Results.csv')
# keithdata = fread('keith/results_complete.csv')
keithperms = c('e10_crashpc75', 'e10_crashpc50', 'e10_crashpc25', 'e6_racismlvl5', 'e6_racismlvl4', 'e6_racismlvl3', 'e6_racismlvl2', 'e6_racismlvl1', 'e2_allblack', 'e2_allwhite')

#identical(round(keithdata$cc.commonweight, 5), round(ccesplus$cc.commonweight, 5))
#View(data.table(keithdata$cc.commonweight, ccesplus$cc.commonweight))

for (i in 1:length(keithperms)) {
    yhats$rf[[keithperms[i]]] = data.table(keithdata[, i + 1, with = F], weight = ccesplus$cc.commonweight_vv_post, statename = ccesplus$statename)
    names(yhats$rf[[keithperms[i]]])[1]='yhat'
}

#keithdata[crashpc_025 == crashpc_075 & !is.na(crashpc_025), tester := 0]
#keithdata[crashpc_025 != crashpc_075, tester := 1]

#dat = data.table(yhats$rf$e10_crashpc25$yhat, yhats$rf$e10_crashpc75$yhat)
#names(dat) = c('crashpc25','crashpc50')
#dat[crashpc25 == crashpc50 & !is.na(crashpc25), tester := 0]
#dat[crashpc25 != crashpc50 , tester := 1]
#View(dat[tester==1])

# Tabulate election results ----------
st.votepost = st.vote
for (model in names(yhats)) {
    for (perm in names(yhats[[model]])) {
        print(paste0(model, '_', perm))
        st.votepost[[paste0(model, '_', perm)]]$dat = ge.rerun(yhats[[model]][[perm]])
    }
}

# Electoral math
for (elec in names(st.votepost)) {
    #elec = names(st.votepost)[3]
    st.votepost[[elec]]$dat$winner = max.col(st.votepost[[elec]]$dat[, 2:ncol(st.votepost[[elec]]$dat)], 'first')
    st.votepost[[elec]]$dat$winner = plyr::mapvalues(st.votepost[[elec]]$dat$winner, c(1, 2, 3), c('gop', 'dem', 'oth'))
    st.votepost[[elec]]$dat = merge(st.votepost[[elec]]$dat, elecvotes)
    st.votepost[[elec]]$dat$gop.pmarg = st.votepost[[elec]]$dat$vote16.gop.pc - st.votepost[[elec]]$dat$vote16.dem.pc
    st.votepost[[elec]]$dat$gop.win = 0
    st.votepost[[elec]]$dat$gop.win[st.votepost[[elec]]$dat$gop.pmarg > 0] = 1
    st.votepost[[elec]]$tally = st.votepost[[elec]]$dat[, sum(evotes), by = winner]
    st.votepost[[elec]]$tallystr = paste('GOP:', st.votepost[[elec]]$tally[winner == 'gop', 2], 'Dem:', st.votepost[[elec]]$tally[winner == 'dem', 2])
}
save(st.votepost, file = 'stvotepost.Rdata')

# Plotting function
plotelec = function(plotdata, savename, plot1.title, plot1.legend, plot2.title, plot2.legend) {
    #plotdata = st.vote$e5_allracist$dat
    #savename = 'tester'
    #plot1.title = 'tester'
    #plot1.legend = 'tester'
    #plot2.title = 'tester'
    #plot2.legend = 'tester'
    # Prep plot data
    col.bluered = c("#0A67FF", "#2959D4", "#494BAA", "#683D7F", "#882F55", "#A7212A", "#C71300")
    dat.winner = plotdata[, .(statename, winner)]
    names(dat.winner) = c('region', 'value')
    dat.winner$region = tolower(dat.winner$region)
    dat.gopmarg = plotdata[, .(statename, gop.pmarg)]
    names(dat.gopmarg) = c('region', 'value')
    dat.gopmarg$region = tolower(dat.gopmarg$region)
    # Generate plots
    plots = list()
    plots$winner = StateChoropleth$new(dat.winner)
    plots$winner$title = plot1.title
    plots$winner$ggplot_scale <- scale_fill_manual(name = plot1.legend, values = c("blue", "red"), drop = FALSE)
    plots$gopmarg = StateChoropleth$new(dat.gopmarg)
    plots$gopmarg$title = plot2.title
    plots$gopmarg$ggplot_scale <- scale_fill_manual(name = plot2.legend, values = col.bluered, drop = FALSE)

    #choro = StateChoropleth$new(df_president)
    #choro$title = "2012 Election Results"
    #choro$ggplot_scale = scale_fill_manual(name = "Candidate", values = c("blue", "red"), drop = FALSE)
    #choro$render()


    # Save plots
    plots$winner$render()
    ggsave(filename = paste0('results/figs/rerun_', savename, '_winner.png'))
    plots$gopmarg$render()
    ggsave(filename = paste0('results/figs/rerun_', savename, '_gopmarg.png'))
    return(plots)
}

#plotelec(plotdata = st.vote$allboys$dat, savename = 'tester',
         #plot1.title = 'tester1', plot2.title = 'tester2',
         #plot1.legend = 'legend1', plot2.legend = 'legend2'
         #)

load('stvotepost.Rdata')
# Create plots ----------
elecplots = list()
for (elec in names(st.votepost)) {
    print(elec)
    elecplots[[elec]] = plotelec(plotdata = st.votepost[[elec]]$dat, savename = elec,
                                    plot1.title = paste(elec, st.votepost[[elec]]$tallystr),
                                    plot2.title = paste(elec, 'GOP margin of victory'),
                                    plot1.legend = st.votepost[[elec]]$tallystr,
                                    plot2.legend = st.votepost[[elec]]$tallystr)
}

#choro = StateChoropleth$new(df_president)
#choro$title = "2012 Election Results"
#choro$ggplot_scale = scale_fill_manual(name = "Candidate", values = c("blue", "red"), drop = FALSE)
#choro$render()


# Old code --------------------

#st.vote$pred.cc0$dat = ge.predict(modcces$mlogit.nofe$m, ccesplus.mlogit, 'pred.cc0')
#st.vote$pred.allgirls$dat = ge.predict(modcces$mlogit.nofe$m, ccesperm$allgirls, 'pred.allgirls')
#st.vote$pred.allblack$dat = ge.predict(modcces$mlogit.nofe$m, ccesperm$allblack, 'pred.allblack')


#data(df_president)
#choro = StateChoropleth$new(df_president)
#choro$title = "2012 Election Results"
#choro$ggplot_scale = scale_fill_manual(name = "Candidate", values = c("blue", "red"), drop = FALSE)
#choro$render()


#tester$alt[tester$alt == '0'] = 'a'
#tester$alt[tester$alt == '1'] = 'a'
#tester$alt[tester$alt == '2'] = 'a'
#tester$alt[tester$alt == '3'] = 'a'
#tester$alt[tester$alt == '4'] = 'a'
#tester$alt[tester$alt == '5'] = 'a'


#st.vote$ge[,winner := max.col(st.vote$ge[, 2:ncol(st.vote$ge)], 'first')]
#st.vote$ge$winner = mapvalues(st.vote$ge$winner, c(1, 2, 3), c('gop', 'dem', 'oth'))
#st.vote$ge = merge(st.vote$ge, elecvotes)
#st.vote$ge$gop.pmarg = st.vote$ge$ge.vote16.gop.pc - st.vote$ge$ge.vote16.dem.pc
#z = st.vote$ge[,sum(evotes), by=winner]
#z = st.vote$ge[, .(statename, gop.pmarg)]

#summary(mlogit(cc.vote16 ~ 0 | cc.Age + cc.Sex, data = ccesplus.mlogit, nests = list(a = c(1, 2, 3), b = c(4, 5, 6, 7, 8))))



# system.time({ mod$nlogit.nofe2$m = multinom(formula2, data = ccesplus) })

# Get predictions
#predict1 = predict(mod$nlogit.nofe$m, newdata = ccesplus.mlogit)
# Get actual prediction of who wins


# z = model.frame(formula1, data = ccesplus.mlogit)

# Get rows used in actual regression
#z = model.frame(formula2, data = ccesplus)

## Cbind y to yhat
#z2 = data.table(z, predict1)

## Compare
#View(z2[, .(cc.vote16, tester)])
#cor(z2[, .(cc.vote16, tester)])
#z2[, correct := 0]
#z2[cc.vote16 == tester, correct := 1]



#tester2 = predict(mod$nlogit.nofe2$m, data = ccesplus)

#data("Fishing", package = "mlogit")
#Fish <- mlogit.data(Fishing, varying = c(2:9), shape = "wide", choice = "mode")
#Fish_fit <- Fish
#Fish_test <- Fish[1:16]
#m <- mlogit(mode ~ price + catch | income, data = Fish_fit)
#predict(m, newdata = Fish_test)

#choro = StateChoropleth$new(df_president)
#choro$title = "2012 Election Results"
#choro$ggplot_scale = scale_fill_manual(name="Candidate", values=c("blue", "red"), drop=FALSE)
#choro$render()

#ge.predict = function(mod, ccesdat.mlogit, name) {
    ## function to predict results
    ##prefix = 'test1'
    ##mod = modcces$mlogit.nofe$m
    ##ccesdat.mlogit = z
    #z.predict = predict(mod, newdata = ccesdat.mlogit) # predict
    ##print(z.predict[1])
    #z.predict = data.table(z.predict, yhat = max.col(z.predict, 'first') - 1) # get winners
    #postest.cces = data.table(model.frame(formula2, data = ccesplus), yhat = z.predict[, yhat]) # merge predictions with estimation data (using formula 2 to also put in some other stuff, like the weights)
    ##postest.cces[[paste0(prefix,.vote16]] = z.predict[, yhat]
    ## Scale up results
    #postest.cces[, vote16.tot := 1]
    #postest.cces[yhat == 0, vote16.novote := 1]
    #postest.cces[yhat == 1, vote16.gop := 1]
    #postest.cces[yhat == 2, vote16.dem := 1]
    #postest.cces[yhat >= 3, vote16.oth := 1]
    #varlist = c('vote16.tot', 'vote16.gop', 'vote16.dem', 'vote16.oth')
    #for (var in varlist) {
        #postest.cces[, paste0(var) := get(var) * cc.commonweight_vv_post] # apply weights
    #}
    ##print(head(postest.cces))
    #pred.st.vote = postest.cces[, lapply(.SD, sum, na.rm = T), by = 'statename', .SDcols = varlist] # sum by state
    ##print(head(pred.st.vote))
    #for (var in c('vote16')) {
        #for (party in c('gop', 'dem', 'oth')) {
            #pred.st.vote[, paste0(var, '.', party, '.pc') := get(paste0(var, '.', party)) / get(paste0(var, '.tot'))]
        #}
    #}
    #return(select(pred.st.vote, statename, contains('.pc')))
#}