loadmain()
gsdat = data.table(gs_read(gstarget, ws = 'cnty interactive'))
reg.guide = gsdat[!is.na(include) & is.na(exclude),
    .(varname.raw, varname.print, table.cat, table.order1, table.order2, include,exclude,flag1,flag2)]
reg.guide = reg.guide[order(table.order1, table.order2)]
v.x = reg.guide[include == 'x']$varname.raw
v.x.withfe = c(v.x, 'stateabr')
v.y = reg.guide[include == 'y']$varname.raw
xlabels = reg.guide[include != 'y']$varname.print


# regdata = as.data.frame(ccesplus[, c(v.x.withfe, v.y), with = F])

mod = list()
for (var in v.y) {
    #var = 'cc.TrumpGEVote'
    ## With State FEs
    # OLS
    formula = as.formula(paste(var, "~", paste(v.x.withfe, collapse = '+')))
    mod$ols$m[[var]] = lm(formula = formula, data = main)
    # Feature Scaled
}


rmarkdown::render(input = paste0(respath, 'regout_cnty.Rmd'),
          output_file = paste0(respath, 'regout.html'))
