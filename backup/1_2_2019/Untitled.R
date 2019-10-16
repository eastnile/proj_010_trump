cc.x1 = rnorm(100)
x2 = rnorm(100)
x3 = rnorm(100)
y = rnorm(100)

dat = data.frame(y=y,cc.x1=cc.x1,x2=x2,x3=x3)

mod= rfsrc(y ~ cc.x1 + x2 +x3,
           data=dat, 
           na.action = 'na.omit', 
           ntree = 500,  
           importance = T)

z = c('a','b','c')

names(z)=c('cc.x1','x2','x3')

plot(gg_vimp(mod),lbls=z)
