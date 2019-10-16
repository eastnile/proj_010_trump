a = 3


g <- data.table(pop=c(1,2,3),b=c(10,20,30),c=c(2,4,6))

vars=c('b','c')


tester = function(wrkdata,varlist,popvar='pop'){
   for (var.i in varlist) {
   var = parse(text=var.i)
   popvar = parse(text=popvar)
   eval(substitute(
      wrkdata <- wrkdata[,paste(var.i,'.pc',sep='') := eval(var)/eval(popvar)]),
      parent.frame())
   }
}

tester(g,vars,'b')
head(g)

eval(substitute(g <- data.table(a=c(1,2,3),b=c(1,2,3))))



tester = function(wrkdata,varlist){
   for (var in varlist)
      
      print(varlist[2])
   var = parse(text=varlist[2])
   eval(substitute(
      wrkdata <- wrkdata[,paste('y',varlist[2]):=a/eval(var)]),
      parent.frame())
}



z <- quote(y <- x * 10)

x <- quote(read.csv("important.csv", row.names = FALSE))
