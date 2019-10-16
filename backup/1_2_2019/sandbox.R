
gsdat = data.table(gs_read(codebook.gs, ws = 'regdir'))
gsdat = gsdat[!is.na(include) & is.na(exclude), .(regid,regdscr,varname.raw,varname.print,table.cat,table.order1,table.order2,exclude,include,flag1,flag2)]

getFormula = function(regid, regdir) {
    t = gsdat[regid == regid]
    t = t[order(table.order1, table.order2)]
    v.x = t[include != 'y']$varname.raw
    v.y = t[include == 'y']$varname.raw
    xlabels = t[include != 'y']$varname.print
    # regdata = as.data.frame(ccesplus[, c(v.x.withfe, v.y), with = F])
    formula = as.formula(paste(v.y, "~", paste(v.x.withfe, collapse = '+')))
    return(formula)
}

regid = 1.1

