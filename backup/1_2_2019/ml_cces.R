loadmain()
libs = c('Metrics','rpart','rpart.plot','caTools','Metrics',
         'randomForest', 'randomForestSRC', 'ggRandomForests')
installif(libs)
lib(libs)

gsdat = data.table(gs_read(codebook.gs, ws = 'regdir'))
regdir = gsdat[!is.na(include) & is.na(exclude), .(regid, regdscr, varname.raw, varname.print, table.cat, table.order1, table.order2, exclude, include, flag1, flag2)]
regdir[order(table.order1, table.order2)]


reg.guide = regdir[regid==1.1]
v.x = reg.guide[include!='y']$varname.raw
v.y = reg.guide[include == 'y']$varname.raw
xlabels = reg.guide[include != 'y']$varname.print
regdata = as.data.frame(ccesplus[,c(v.x,v.y),with=F])

mod = list()
system.time({
for (var in v.y) {
  formula = as.formula(paste(var,"~",paste(v.x,collapse='+')))
  mod$rf.slow[[var]] = rfsrc(formula,
                        data = ccesplus, 
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
