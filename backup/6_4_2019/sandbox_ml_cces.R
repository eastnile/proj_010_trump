loadmain()
libs = c('Metrics','rpart','rpart.plot','caTools','Metrics',
         'randomForest', 'randomForestSRC', 'ggRandomForests')
installif(libs)
lib(libs)


regdir.good = data.table(gs_read(gstarget, ws = 'regdir'))
regdir.cces.interact = data.table(gs_read(gstarget, ws = 'ccesplus guide'))
regdir.cnty.interact = data.table(gs_read(gstarget, ws = 'cnty interactive'))

t = getReg(1.1,regdir.good)

v.x = t$v.x
v.y = t$v.y
xlabels = t$xlab
ccesplus.fscaled$stateabr = as.factor(ccesplus.fscaled$stateabr)

z = ccesplus.fscaled[c(v.y,v.x.withfe)]


modml = list()
system.time({
for (var in v.y) {
  formula = as.formula(paste(var,"~",paste(v.x,collapse='+')))
  modml$rf.slow[[var]] = rfsrc(formula,
                        data = ccesplus.fscaled, 
                        na.action = 'na.omit',
                        ntree = 300,
                        importance = T)
}
})


xlblrf = xlabels
names(xlblrf) = v.x

plot(gg_vimp(mod$rf.slow$cc.TrumpGEVote),lbls=xlblrf)
plot(gg_minimal_depth(mod$rf.slow$cc.TrumpGEVote),lbls=xlblrf)

summary(ccesplus$cc.isimmigrant)

model.rfreg.1 = randomForest(trumpstrnorm ~ mort.ucd.drugalc.disc95.pdpy + crashpc + edu.bs.p + rustpc + relig.evan.pc,
                             data=main, na.action = na.omit, ntree = 500,  importance = T)

yhat.rfreg.1 = as.data.frame(predict(model.rfreg.1, newdata = test))
yhat = data.frame(yhat,yhat.rfreg.1)

model.rfreg.1$importance                                
partialPlot(model.rfreg.1, train, mort.ucd.drugalc.disc95.pdpy)
partialPlot(model.rfreg.1, train, crashpc)
partialPlot(model.rfreg.1, train, edu.bs.p)
partialPlot(model.rfreg.1, train, rustpc)
partialPlot(model.rfreg.1, train, relig.evan.pc)
