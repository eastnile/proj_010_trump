loadmain()
main = na.omit(select(main,trumpstrnorm,matches('mort.ucd.*.pdpy'),crashpc,edu.bs.p,rustpc,relig.evan.pc))

installif('Metrics')
library(caTools)
library(Metrics)
# Split
set.seed(123)
split = sample.split(main$trumpstrnorm, SplitRatio = 4/5)
train = subset(main,split==T)
test = subset(main,split==F)
yhat = data.frame()

# Fit OLS
model.ols.1 = lm(trumpstrnorm ~ mort.ucd.drugalc.disc95.pdpy + crashpc + edu.bs.p + rustpc + relig.evan.pc,
               data = train)

yhat.ols.1 = as.data.frame(predict(model.ols.1, newdata = test))
yhat = data.frame(test$trumpstrnorm,yhat.ols.1)

# Fit Decision Tree:
require(rpart)
model.dtreg.1 = rpart(formula = trumpstrnorm ~ mort.ucd.drugalc.disc95.pdpy + crashpc + edu.bs.p + rustpc + relig.evan.pc,
                      data = train,
                      method='anova',
                      control = rpart.control(minsplit = 5)
                      )

yhat.dtreg.1 = as.data.frame(predict(model.dtreg.1, newdata = test))
yhat = data.frame(yhat,yhat.dtreg.1)
#Visualize:
require(rpart.plot)
rpart.plot(model.dtreg.1)
#plot(model.dtreg.1)
# text(model.dtreg.1)

# Fit Random Forest
installif('randomForest')
require(randomForest)
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

# Compute MSE
resid=data.frame(matrix(nrow=nrow(yhat),ncol=0))
sqresid=data.frame(matrix(nrow=nrow(yhat),ncol=0))
for (i in 1:ncol(yhat)) {
   resid[[names(yhat)[i]]]=(yhat[,1]-yhat[,i])
   sqresid[[names(yhat)[i]]]=(yhat[,1]-yhat[,i])^2
}
t = setDT(sqresid)
mse = t[,lapply(.SD,sum,na.rm=T)]

