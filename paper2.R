# Prep -----
library(margins)
library(stargazer)
loadmain()
reg.gs = gs_key('1zvWKThk0qleArw62qK4RFSzg8JLz8BAnfZrGxi-yNtg')

# Functions -----
getreg = function(regdir) {
    regobj = list()
    vartablenames = names(regdir)
    # Prep reg0, the baseline regression
    regobj$reg0 = list()
    regobj$reg0$xtable = regdir[regid1 == 0 & info == 'x' & is.na(exclude)]
    regitem.other = c('y', 'conditions', 'dtname', 'xaddendum', 'est.switch', 'postest.switch')
    for (item in regitem.other) {
        regobj$reg0[[item]] = regdir[regid1 == 0 & info == item, commands]
    }
    nreg = max(unique(regdir$regid1), na.rm = T)
    if (nreg == 0) {
        # Allows regid = 0 only
        nreg = length(unique(regdir$regid1))
        names(regobj$regs) = as.character(unique(na.omit(regdir$regname.print)))
    } else {
        # If there's more than one reg, regid = 0 becomes "silent"
        regobj$regs = vector('list', length = nreg)
        names(regobj$regs) = as.character(unique(na.omit(regdir[regid1 > 0, regname.print])))
    }
    regobj$meta = NULL
    for (i in 1:nreg) {
        # Main loop
        #i = 1
        # 1. Add to regobj$reg0$xtable with new values to form reg1, reg2, etc, or remove if exclude==1
        z = merge(regobj$reg0$xtable, regdir[regid1 == i & (info == 'x')],
                  by = c('xname.raw'), suffixes = c('.old', ''), all = T) # 1. For xtable
        for (var in setdiff(vartablenames, c('regid1','regid2','xname.raw'))) { # update values in xtable xtable
            z[is.na(get(var)), paste0(var) := get(paste0(var, '.old'))]
        }
        regobj$regs[[i]]$xtable = select(z, - contains('.old'))[is.na(exclude)]
        # 2. Do the same for other regression objects
        for (item in regitem.other) {
            regobj$regs[[i]][[item]] = union(regobj$reg0[[item]], regdir[regid1 == i & info == item & is.na(exclude), commands])
            regobj$regs[[i]][[item]] = setdiff(regobj$regs[[i]][[item]], regdir[regid1 == i & info == item & exclude == 1, commands])
        }
        # 3. Process xaddendum and formula
        xaddendum = tryCatch(eval(parse(text = regobj$regs[[i]]$xaddendum)),
                             error = function(e) return(regobj$regs[[i]]$xaddendum))
        regobj$regs[[i]]$formula.str = paste0(regobj$regs[[i]]$y, '~',
                                              paste(regobj$regs[[i]]$xtable$xname.raw, collapse = '+'),
                                              ifelse(length(xaddendum) == 0, '', paste0('+', xaddendum))
        )
        # Write metadata
        z = data.table(regid = i, regname.print = names(regobj$regs)[i], t(regobj$regs[[i]][2:length(regobj$regs[[i]])]))
        regobj$meta = rbind(z, regobj$meta)
    }
    regobj$meta = regobj$meta[order(regid)]
    regobj$meta[is.na(regname.print),regname.print := regid]
    return(regobj)
}
postest.ame = function(mod) {
    #mod = modobj$models[[1]]
    # establish means
    data = as.data.table(mod$model)
    isdum = sapply(data, function(x) { all(x %in% c(0:1, NA)) })
    dt.mean.0 = data[, lapply(.SD, mean, na.rm = TRUE)]
    ame = numeric()
    for (x in names(mod$model)[2:length(mod$model)]) {
        
        #x = names(mod$model)[2:length(mod$model)][1]
        if (isdum[x]) {
            #if (1==2) {
            #print(paste(x,' is dum'))
            dt.mean.0.dum = copy(dt.mean.0)
            dt.mean.0.dum[[x]] = 0
            dt.mean.1.dum = copy(dt.mean.0)
            dt.mean.1.dum[[x]] = 1
            ame[[x]] = predict(mod, newdata = dt.mean.1.dum, type = 'response') - predict(mod, newdata = dt.mean.0.dum, type = 'response')
        } else {
            #print(paste(x, ' is not dum'))
            dt.mean.1 = copy(dt.mean.0);
            dt.mean.1[[x]] = dt.mean.1[[x]] + 1;
            ame[[x]] = predict(mod, newdata = dt.mean.1, type = 'response') - predict(mod, newdata = dt.mean.0, type = 'response')
        }
    }
    return(data.table(factor = names(ame), myame = ame))
}
estreg = function(regobj, postest = F, long = F) {
    nreg = length(regobj$regs)
    mod = list()
    mod$meta = regobj$meta
    # Estimation
    for (i in 1:nreg) {
        print(names(regobj$regs[i]))
        # Apply conditions
        if (length(regobj$regs[[i]]$conditions) == 0) {
            regdata = get(regobj$regs[[i]]$dtname)
        } else {
            #regdata = get(regobj$regs[[i]]$dtname)[eval(parse(text = regobj$regs[[i]]$conditions)),]
            regdata = get(regobj$regs[[i]]$dtname)[eval(parse(text = paste('(',regobj[["meta"]]$conditions[[i]],')',collapse='&'))),]
        }
        # Run models based on est.switch
        if ('ols' %in% regobj$regs[[i]]$est.switch) {
            mod$models[[i]] = lm(formula = as.formula(regobj$regs[[i]]$formula.str), data = regdata)
        }
        if ('logit' %in% regobj$regs[[i]]$est.switch) {
            mod$models[[i]] = glm(formula = as.formula(regobj$regs[[i]]$formula.str), data = regdata,
                                  family = binomial(link = 'logit'))
        }
        if (1 == 0) {
            #statement3
        }
    }
    names(mod$models)=regobj$meta$regname.print
    if (postest == F) { return(mod) }
    # Post-estimation
    for (i in 1:nreg) {
        # Apply conditions
        #if (length(regobj$regs[[i]]$conditions) == 0) {
        #regdata = get(regobj$regs[[i]]$dtname)
        #} else {
        #regdata = get(regobj$regs[[i]]$dtname)[eval(parse(text = regobj$regs[[i]]$conditions)),]
        #}
        # Run models based on postest.switch
        if ('ame' %in% regobj$regs[[i]]$postest.switch) {
            
            mod$postest$ame[[i]] = postest.ame(mod$models[[i]])
            #[[i]] = lm(formula = as.formula(regobj$regs[[i]]$formula.str), data = regdata)
        }
        
        if ('margins' %in% regobj$regs[[i]]$postest.switch) {
            z = as.data.table(mod$models[[i]]$model)[, lapply(.SD, mean, na.rm = TRUE)]
            #print(z)
            mod$postest$mem[[i]] = summary(margins(mod$models[[i]], data = z, vce = 'delta')) # margins
            mod$postest$mem[[i]] = margin.star(mod$postest$mem[[i]])
        }
    }
    #names(mod$postest$ame) = regobj$meta$regname.print
    #names(mod$postest$mem) = regobj$meta$regname.print
    if (!long) {
        return(mod)
    }
    else {
        return(postestToLong(mod$postest,mod$meta))
    }

}
margin.star = function(margins.sum) {
    margins.sum = as.data.table(margins.sum)
    margins.sum[, amestar := '']
    margins.sum[p <= 0.05, amestar := '*']
    margins.sum[p <= 0.01, amestar := '**']
    margins.sum[p <= 0.001, amestar := '***']
    margins.sum[, AMEstr := paste0('\'', format(round(AME*100, 3),nsmall=3),'%', amestar)]
    return(margins.sum)
}
postestToLong = function(postest.obj, meta) {
    z = list()
    for (i in 1:length(postest.obj)) {
        #print(postest.obj[[i]])
        z[[i]] = tableToLong(postest.obj[[i]])
        #print(z[[i]])
    }
    z = do.call(rbind, z)
    z = merge(z, meta[, regid, regname.print], by.x = 'regid1', by.y = 'regid', all.x = T)
    z[, info := paste0(regname.print, '.', variable)]
    # dump
}
tableToLong = function(mod.postest) {
    z = list()
    for (i in 1:length(mod.postest)) {
        z[[i]] = melt(as.data.table(mod.postest[[i]]), id.vars = 1)
        z[[i]][, regid1 := i]
    }
    return(do.call(rbind, z))
}

longtable.stargazer = function(..., float = T, longtable.float = F, 
                               longtable.head = T, filename = NULL){
    # Capturing stargazer to hack it
    require(stargazer)
    res = capture.output(
        stargazer(..., float = float)
    )
    # Changing tabulare environment for longtable
    res = gsub("tabular", "longtable", res)
    # removing floating environment
    if(float == T & longtable.float == F){
        res[grep("table", res)[1]] = res[grep("longtable", res)[1]]
        # Removing extra longtable commands
        res = res[-grep("longtable", res)[2]]
        res = res[-length(res)]
    }
    # Adding page headings
    if(longtable.head == T){
        res = c(res[1:which(res == "\\hline \\\\[-1.8ex] ")[1] - 1], "\\endhead", res[which(res == "\\hline \\\\[-1.8ex] ")[1]:length(res)])
    }
    # Exporting
    cat(res, sep = "\n")
    # Exporting
    if(!is.null(filename)){
        cat(res, file = filename, sep = "\n")
        # Message
        cat(paste("\nLaTeX output printed to", filename, "\n", sep = " ", 
                  collapse = ""))
    }else{
        cat(res, sep = "\n")
    }
}

# Tables -----

# Table 1A: Trump predictors for all groups -----
reg1 = data.table(gs_read(reg.gs, ws = 'regdir_table1'))[regid2 == 1 | regid2 == 3] %>% getreg() # with raceviewsum
reg2 = data.table(gs_read(reg.gs, ws = 'regdir_table1'))[regid2 == 2 | regid2 == 3] %>% getreg() # with breakdown
res1 = reg1 %>% estreg(postest=T, long=T)
res2 = reg2 %>% estreg(postest = T, long = T)

z0 = data.table::dcast(res2[variable %in% c('AME')], factor ~ info)
z1 = data.table::dcast(res2[variable %in% c('AMEstr')], factor ~ info)
z2 = data.table::dcast(res2[variable %in% c('p')], factor ~ info)

maxval = max(as.numeric(as.matrix(z0[, - (1:2)])), na.rm = T)
minval = min(as.numeric(as.matrix(z0[, - (1:2)])), na.rm = T)

prep0 = function(x) {
    x = as.numeric(x)
    x = abs(ifelse(x>0, x/maxval, -x/maxval))
    #x = trunc(rank(x))/length(x)
    return(x)
}
prep1 = function(x) {
    #x = z1[[3]]
    x[is.na(x)] = ''
    return(x)
}
prep2 = function(x) {
    #x = z2$romney.ge.logit.ind.p
    x = format(round(as.numeric(x),digits=3),nsmall=3)
    x = paste0('\'(',x,')')
    x[str_detect(x,'NA')] = ''
    return(x)
}

z0[,2:length(z1)] = z0[, lapply(.SD, prep0), .SDcols=2:length(z1)]
z1[,2:length(z1)] = z1[, lapply(.SD, prep1), .SDcols=2:length(z1)]
z2[,2:length(z2)] = z2[, lapply(.SD, prep2), .SDcols=2:length(z2)]
z3 = rbindlist(list(z1,z2),use.names = F)[order(factor)]
temp = z2
temp[,2:length(z2)]=0
raw = rbindlist(list(z0,temp),use.names=F)[order(factor)]

xnames = reg2$regs[[1]]$xtable[,.(xname.raw,xname.print,xtable.section,xtable.order)]
out = list()

for (object in c('z3','raw')) {
    z=merge(get(object),xnames,by.x='factor',by.y='xname.raw',all.x=T)
    setcolorder(z,c('factor','xname.print','xtable.section','xtable.order',
                    rev(str_subset(names(z),'.all')),
                    rev(str_subset(names(z),'.gop')),
                    rev(str_subset(names(z),'.ind'))    
        )
    )
    z$xname.print[seq(2, nrow(z3), 2)] = ''
    z=z[order(xtable.order)]
    out[[object]] = z
}
out$raw$xtable.order = NULL
out$raw = add_column(out$raw, spacer1 = 0, .after = 9)
out$raw = add_column(out$raw, spacer2 = 0, .after = 6)

reg.gs = gs_key('1zvWKThk0qleArw62qK4RFSzg8JLz8BAnfZrGxi-yNtg')
gs_edit_cells(ss = reg.gs, ws = 'table1_format', input = out$raw, anchor = "A3", verbose = F)
gs_edit_cells(ss = reg.gs, ws = 'table1_raw', input = out$z3, anchor = "A1", verbose = F)

# Table 1Bi: # RF Model ------------
keith.url.mem = 'https://raw.githubusercontent.com/kperkins411/Voteranalysis_RECALCS/master/outBElectionResultsMEMs/'
mem.url = c('MEMS_cc.trumppvote_rf.csv',
            'MEMS_cc.trumpgevote_rf.csv',
            'MEMS_cc.vote12.gop_rf.csv',
            'MEMS_cc.trumppvote_cc.repdum_rf.csv',
            'MEMS_cc.trumpgevote_cc.repdum_rf.csv',
            'MEMS_cc.vote12.gop_cc.repdum_rf.csv',
            'MEMS_cc.trumppvote_cc.inddum_rf.csv',
            'MEMS_cc.trumpgevote_cc.inddum_rf.csv',
            'MEMS_cc.vote12.gop_cc.inddum_rf.csv')

keith.url.pval = 'https://raw.githubusercontent.com/kperkins411/Voteranalysis_RECALCS/master/outBElectionResultsPVALSs/'
pval.url = c('pvalsTrumpPVote.csv',
            'pvalsTrumpGEVote.csv',
            'pvalsvote12gop.csv',
            'pvalsTrumpPVote_cc.repdum.csv',
            'pvalsTrumpGEVote_cc.repdum.csv',
            'pvalsvote12gop_cc.repdum.csv',
            'pvalsTrumpPVote_cc.inddum.csv',
            'pvalsTrumpGEVote_cc.inddum.csv',
            'pvalsvote12gop_cc.inddum.csv')

z0 = fread(paste0(keith.url.mem, mem.url)[1])[, 2]
names(z0)='factor'
for (url in mem.url) {
    #url = mem.url[1]

    z = fread(paste0(keith.url.mem,url))[, c(2,8)]
    names(z) = c('factor',url)
    z0 = merge(z0,z)
}
z0 = z0[order(factor)]
z2 = fread(paste0(keith.url.pval, pval.url)[1])[, 1]
names(z2) = 'factor'
for (url in pval.url) {
    #url = mem.url[1]
    z = fread(paste0(keith.url.pval, url))[, c(1, 2)]
    names(z) = c('factor', url)
    z2 = merge(z2, z)
}
z2 = z2[order(factor)]

keith.star = function(mem, pval) {
    #mem = z0[, 2]
    #pval = z2[, 2]
    star = rep('',length(mem))
    star[pval <= 0.05] = '*'
    star[pval <= 0.01] = '**'
    star[pval <= 0.001] = '***'
    amestar = paste0('\'', format(round(mem * 100, 3), nsmall = 3), '%', star)
    return(amestar)
}

z = mapply(keith.star, z0[, -1], z2[, -1])
z1 = as.data.table(cbind(z0[, 1], z))

maxval = max(as.numeric(as.matrix(z0[, - (1:2)])), na.rm = T)
minval = min(as.numeric(as.matrix(z0[, - (1:2)])), na.rm = T)

z0[, 2:length(z1)] = z0[, lapply(.SD, prep0), .SDcols = 2:length(z1)]
z1[, 2:length(z1)] = z1[, lapply(.SD, prep1), .SDcols = 2:length(z1)]
z2[, 2:length(z2)] = z2[, lapply(.SD, prep2), .SDcols = 2:length(z2)]
z3 = rbindlist(list(z1, z2), use.names = F)[order(factor)]
temp = z2
temp[, 2:length(z2)] = 0
raw = rbindlist(list(z0, temp), use.names = F)[order(factor)]

xnames = reg2$regs[[1]]$xtable[, .(xname.raw, xname.print, xtable.section, xtable.order)]
xnames$xname.raw = tolower(xnames$xname.raw)
out = list()

for (object in c('z3', 'raw')) {
    z = merge(get(object), xnames, by.x = 'factor', by.y = 'xname.raw', all.x = T)
    setcolorder(z, c('factor', 'xname.print', 'xtable.section', 'xtable.order'
                    #rev(str_subset(names(z), '.all')),
                    #rev(str_subset(names(z), '.gop')),
                    #rev(str_subset(names(z), '.ind'))
        )
    )
    z$xname.print[seq(2, nrow(z3), 2)] = ''
    z = z[order(xtable.order)]
    out[[object]] = z
}

out$raw$xtable.order = NULL
out$raw = add_column(out$raw, spacer1 = 0, .after = 9)
out$raw = add_column(out$raw, spacer2 = 0, .after = 6)

reg.gs = gs_key('1zvWKThk0qleArw62qK4RFSzg8JLz8BAnfZrGxi-yNtg')
gs_edit_cells(ss = reg.gs, ws = 'table2_format', input = out$raw, anchor = "A3", verbose = F)
gs_edit_cells(ss = reg.gs, ws = 'table2_raw', input = out$z3, anchor = "A1", verbose = F)

# Table 1B: Trump predictors Midwest Only -----
reg2 = data.table(gs_read(reg.gs, ws = 'regdir_table1'))[regid2 == 2 | regid2 == 3 | regid2 == 4] %>% getreg() # with breakdown
res2 = reg2 %>% estreg(postest = T, long = T)

z0 = data.table::dcast(res2[variable %in% c('AME')], factor ~ info)
z1 = data.table::dcast(res2[variable %in% c('AMEstr')], factor ~ info)
z2 = data.table::dcast(res2[variable %in% c('p')], factor ~ info)

prep0 = function(x) {
    x = as.numeric(x)
    x = abs(ifelse(x > 0, x / maxval, - x / maxval))
    #x = trunc(rank(x))/length(x)
    return(x)
}
prep1 = function(x) {
    #x = z1[[3]]
    x[is.na(x)] = ''
    return(x)
}
prep2 = function(x) {
    #x = z2$romney.ge.logit.ind.p
    x = format(round(as.numeric(x), digits = 3), nsmall = 3)
    x = paste0('\'(', x, ')')
    x[str_detect(x, 'NA')] = ''
    return(x)
}

z0[, 2:length(z1)] = z0[, lapply(.SD, prep0), .SDcols = 2:length(z1)]
z1[, 2:length(z1)] = z1[, lapply(.SD, prep1), .SDcols = 2:length(z1)]
z2[, 2:length(z2)] = z2[, lapply(.SD, prep2), .SDcols = 2:length(z2)]
z3 = rbindlist(list(z1, z2), use.names = F)[order(factor)]
temp = z2
temp[, 2:length(z2)] = 0
raw = rbindlist(list(z0, temp), use.names = F)[order(factor)]

xnames = reg2$regs[[1]]$xtable[, .(xname.raw, xname.print, xtable.section, xtable.order)]
out = list()

for (object in c('z3', 'raw')) {
    z = merge(get(object), xnames, by.x = 'factor', by.y = 'xname.raw', all.x = T)
    setcolorder(z, c('factor', 'xname.print', 'xtable.section', 'xtable.order',
                    rev(str_subset(names(z), '.all')),
                    rev(str_subset(names(z), '.gop')),
                    rev(str_subset(names(z), '.ind'))
        )
    )
    z$xname.print[seq(2, nrow(z3), 2)] = ''
    z = z[order(xtable.order)]
    out[[object]] = z
}
out$raw$xtable.order = NULL
out$raw = add_column(out$raw, spacer1 = 0, .after = 9)
out$raw = add_column(out$raw, spacer2 = 0, .after = 6)

reg.gs = gs_key('1zvWKThk0qleArw62qK4RFSzg8JLz8BAnfZrGxi-yNtg')
gs_edit_cells(ss = reg.gs, ws = 'table1b_format', input = out$raw, anchor = "A3", verbose = F)
gs_edit_cells(ss = reg.gs, ws = 'table1b_raw', input = out$z3, anchor = "A1", verbose = F)

# Table 3 Biggest Winners/Losers 12 vs 16 -------------

out = list()
reg = list()
res = list()

reg$all = data.table(gs_read(reg.gs, ws = 'regdir_table1'))[regid2 == 2 | regid2 == 3] %>% getreg() # with breakdown
res$all = reg$all %>% estreg(postest = T, long = T)
reg$midwest = data.table(gs_read(reg.gs, ws = 'regdir_table1'))[regid2 == 2 | regid2 == 3 | regid2 == 4] %>% getreg() 
res$midwest = reg$midwest %>% estreg(postest = T, long = T)

z1 = list()
z2 = list()
z3 = list()

xnames = reg$all[[1]]$xtable[, .(xname.raw, xname.print, xtable.section, xtable.order)]

prep2 = function(x) {
    #x = z2$romney.ge.logit.ind.p
    x = format(round(as.numeric(x)*100, digits = 3), nsmall = 3)
    x = paste0(x,'%')
    #margins.sum[, AMEstr := paste0('\'', format(round(AME * 100, 3), nsmall = 3), '%', amestar)]
    #x = paste0('\'(', x, ')')
    #x[str_detect(x, 'NA')] = ''
    return(x)
}

for (i in c('all', 'midwest')) {
    #i = 'ge'
    #z1[[i]] = data.table::dcast(res[['all']][variable %in% c('AME')], factor ~ info)
    z1[[i]] = data.table::dcast(res[[i]][variable %in% c('AME')], factor ~ info)
    z1[[i]][, 2:length(z1[[i]])] = z1[[i]][, lapply(.SD, as.numeric), .SDcols = 2:length(z1[[i]])]
    z1[[i]][, paste0('diff_', i) := trump.ge.logit.all.AME - romney.ge.logit.all.AME]

    z3[[i]] = data.table::dcast(res[[i]][variable %in% c('AMEstr')], factor ~ info)

    z1[[i]] = cbind(z1[[i]],z3[[i]][,-1])
    z1[[i]] = merge(z1[[i]], xnames, by.x = 'factor', by.y= 'xname.raw')
    z1[[i]] = z1[[i]][order(-get(paste0('diff_', i)))]



    z2[[i]] = z1[[i]][, c('xname.print', 'trump.ge.logit.all.AMEstr', 'romney.ge.logit.all.AMEstr', paste0('diff_', i)), with = F]
    z2[[i]][, length(z2[[i]])] = z2[[i]][, lapply(.SD, prep2), .SDcols = length(z2[[i]])]
}

#gs_edit_cells(ss = reg.gs, ws = 'table1b_format', input = out$raw, anchor = "A3", verbose = F)
gs_edit_cells(ss = reg.gs, ws = 'table3_raw', input = z2$all, anchor = "A1", verbose = F)
gs_edit_cells(ss = reg.gs, ws = 'table3_raw', input = z2$midwest, anchor = "F1", verbose = F)

# Table 4: Race/Econ Interaction -----------
reg.gs = gs_key('1zvWKThk0qleArw62qK4RFSzg8JLz8BAnfZrGxi-yNtg')
reg = data.table(gs_read(reg.gs, ws = 'regdir_table4'))[regid2 == 2 | regid2 == 3] %>% getreg() # with breakdown
res = reg %>% estreg(postest = T, long = T)

z0 = data.table::dcast(res[variable %in% c('AME')], factor ~ info)
z1 = data.table::dcast(res[variable %in% c('AMEstr')], factor ~ info)
z2 = data.table::dcast(res[variable %in% c('p')], factor ~ info)

#prep0 = function(x) {
    #x = as.numeric(x)
    #x = abs(ifelse(x > 0, x / maxval, - x / maxval))
    ##x = trunc(rank(x))/length(x)
    #return(x)
#}
prep1 = function(x) {
    #x = z1[[3]]
    x[is.na(x)] = ''
    return(x)
}
prep2 = function(x) {
    #x = z2$romney.ge.logit.ind.p
    x = format(round(as.numeric(x), digits = 3), nsmall = 3)
    x = paste0('\'(', x, ')')
    x[str_detect(x, 'NA')] = ''
    return(x)
}

#z0[, 2:length(z1)] = z0[, lapply(.SD, prep0), .SDcols = 2:length(z1)]
z1[, 2:length(z1)] = z1[, lapply(.SD, prep1), .SDcols = 2:length(z1)]
z2[, 2:length(z2)] = z2[, lapply(.SD, prep2), .SDcols = 2:length(z2)]
z3 = rbindlist(list(z1, z2), use.names = F)[order(factor)]

xnames = reg$regs[[5]]$xtable[, .(xname.raw, xname.print, xtable.section, xtable.order)]

z = merge(z3, xnames, by.x = 'factor', by.y = 'xname.raw', all.x = T)

setcolorder(z, c('factor', 'xname.print', 'xtable.section', 'xtable.order',
                    (str_subset(names(z), '.ge.*.job')),
                    str_subset(names(z), '.ge.all.crash'),
                    str_subset(names(z), '.ge.all.rust'),
                    rev(str_subset(names(z), '.pri.*.job')),
                    str_subset(names(z), '.pri.all.crash'),
                    str_subset(names(z), '.pri.all.rust')))

z$xname.print[seq(2, nrow(z3), 2)] = ''
z = z[order(xtable.order)]
gs_edit_cells(ss = reg.gs, ws = 'table4_raw', input = z, anchor = "A1", verbose = F)

# Old code --------------

# z = %>% postestToLong(res1, )
# 
# 
# res2 = reg2 %>% estreg(postest=T) %>% postestToLong()

# For appendix: raw regression output
#z = stargazer(res1$models, type='text', column.labels = letters[1:9], dep.var.labels = letters[1:3], multicolumn = F)

# Actual Table
#z = data.table::dcast(z[variable %in% c('AME')], factor ~ info)


# stargazer(res1$models, title='tester', report = 'vc*sp',covariate.labels = xnames1$xname.print, out = 'results/tables/tester.html')
# longtable.stargazer(res1$models, type='latex', title='tester', report = 'vc*sp',covariate.labels = xnames1$xname.print, filename = 'results/tables/tester.tex')

# xnames1 = reg1$regs[[1]]$xtable[,.(xname.raw,xname.print,xtable.section)]
# xnames2 = reg2$regs[[2]]$xtable[,.(xname.raw,xname.print,xtable.section)]
# xnames = union(xnames1,xnames2)


# require(stargazer)
# xlabels = c('a','b','c')
# stargazer(mod, type = 'html', title = 'tester', report = 'vc*sp', covariate.labels = xlabels)
# ```

#prep0 = function(x) {
    #x = as.numeric(x)
    #x = abs(ifelse(x > 0, x / max(x, na.rm = T), - x / min(x, na.rm = T)))
    ##x = trunc(rank(x))/length(x)
    #return(x)
#}

#getKeithAme = function() {
#names = c('factor','trump.ge.rf', 'trump.pri.rf', 'romney.ge.rf')
#z1 = fread('https://raw.githubusercontent.com/kperkins411/VoterAnalysis/master/outBElectionResultsScaled2/MEMS_cc.TrumpGEVote.csv')[, c(2,8)]
#z2 = fread('https://raw.githubusercontent.com/kperkins411/VoterAnalysis/master/outBElectionResultsScaled2/MEMS_cc.TrumpPVote.csv')[, 8]
#z3 = fread('https://raw.githubusercontent.com/kperkins411/VoterAnalysis/master/outBElectionResultsScaled2/MEMS_cc.vote12.gop.csv')[, 8]
#z = data.table(z1, z2, z3)
#names(z) = names
#return(z)
#}