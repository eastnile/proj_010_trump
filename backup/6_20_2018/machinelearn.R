loadmain()
wrkdata = na.omit(wrkdata)
library(caTools)
library(Metrics)
# Split
set.seed(123)
split = sample.split(wrkdata$TrumpStrength, SplitRatio = 4/5)
train = subset(wrkdata,split==T)
test = subset(wrkdata,split==F)
yhat = data.frame()

# Fit OLS
model.ols.1 = lm(TrumpStrength ~ mort.ucd.drugalc.pc + crash1 + edu.bs.p,
               data = train)

yhat.ols.1 = as.data.frame(predict(model.ols.1, newdata = test))
yhat = data.frame(test$TrumpStrength,yhat.ols.1)

# Fit Decision Tree:
require(rpart)
model.dtreg.1 = rpart(formula = TrumpStrength ~ mort.ucd.drugalc.pc + crash1 + edu.bs.p,
                      data = train,
                      method='anova',
                      control = rpart.control(minsplit = 5)
                      )

yhat.dtreg.1 = as.data.frame(predict(model.dtreg.1, newdata = test))
yhat = data.frame(yhat,yhat.dtreg.1)
#Visualize:
plot(model.dtreg.1)
text(model.dtreg.1)

# Fit Random Forest
model.rfreg.1 = randomForest(TrumpStrength ~ mort.ucd.drugalc.pc + crash1 + edu.bs.p, data=wrkdata, na.action = na.omit, ntree = 500,  importance = T)

yhat.rfreg.1 = as.data.frame(predict(model.rfreg.1, newdata = test))
yhat = data.frame(yhat,yhat.rfreg.1)

model.rfreg.1$importance                                
partialPlot(model.rfreg.1, wrkdata, edu.bs.p, "versicolor")



# Compute MSE
resid=data.frame(matrix(nrow=nrow(yhat),ncol=0))
sqresid=data.frame(matrix(nrow=nrow(yhat),ncol=0))
for (i in 1:ncol(yhat)) {
   resid[[names(yhat)[i]]]=(yhat[,1]-yhat[,i])
   sqresid[[names(yhat)[i]]]=(yhat[,1]-yhat[,i])^2
}
t = setDT(sqresid)
mse = t[,lapply(.SD,sum,na.rm=T)]


data(iris)
set.seed(543)
iris.rf <- randomForest(Sepal.Length~., iris)
partialPlot(iris.rf, iris, Petal.Width)
