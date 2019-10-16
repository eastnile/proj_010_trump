dat <- data.frame(a = 1:3, b = exp(1:3), c = c(1,2,NA))
# compute the list mean for each list element
sapply(dat, function(x) sum(is.na(x)))
z = sapply(X = dat, FUN = function(x) sum(is.na(x)))

na_count <- sapply(x, function(y) sum(length(which(is.na(y)))))

t = main[['relig.orth.pc']]

t = sapply(main, function(x) sum(!is.na(x))/length(x) )


meta = data.table(varname.raw=names(t),pctobs=t)
