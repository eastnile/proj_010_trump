dat = data.table(a = c(1, 2, 3), b = c(1, 2, 3))

obj = list()
obj$table1 = copy(dat)
obj$table1[, a:=7]