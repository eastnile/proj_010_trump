df = data.table(col1 = c("abc","abcd","a","abcdefg"),col2 = c("adf qqwe","d","e","f"))


for(i in names(df)){
   df[[paste(i, 'length', sep="_")]] = nchar(as.character(df[[i]]))
}

df = data.table(col1 = c("abc","abcd","a","abcdefg"),col2 = c("adf qqwe","d","e","f"))


for(i in names(df)[3:4]){
   df[,c(paste(i,"hello")):=2]
   #df[[paste(i, 'length', sep="_")]] = nchar(as.character(df[[i]]))
}


df[,c("tester2"):=2]


A <- iris
setDT(A)

A[,mean := rollapply(Petal.Width, width=2, FUN=function(x) mean(x, na.rm=TRUE), align='right', partial=F, fill=NA), by=Species]

a[,ind11Sm:= rollapply(ind11, width=1, FUN=function(x) mean(x, na.rm=TRUE), align='right', partial=F, fill=NA), by=county]