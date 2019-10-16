# Feature Scaling

require("datasets")
x <- lm(mpg ~ cyl + wt + hp * am, data = mtcars)
margins(x)
cplot(x, "am", what = "prediction", main = "Predicted Fuel Economy, Given Weight")

# install.packages('standardize')
library(standardize)

y = rnorm(10)
x1 = 10*rnorm(10)
x2 = 5*rnorm(10)
x3 = sample(0:1,10,replace=T)
x3[2]=NA


dat = data.table(y,x1,x2,x3)
binary = apply(dat,2,function(x) {all(x %in% 0:1,na.rm=T)})

all(x1 %in% c(0:1,NA))

x3 %in% 0:1

z=dat[,!binary,with=F]

dat[!binary,] = scale(dat[!binary,])

scaleContinuous = function(data) {
  binary = apply(data, 2, function(x) {all(x %in% 0:1)}) 
  data[!binary] = scale(data[!binary])
  return(data)
}

scaleContinuous(dat)
