# Post Estimation:
regdir.good = data.table(gs_read(gstarget, ws = 'regdir'))
#regdir.cces.interact = data.table(gs_read(gstarget, ws = 'ccesplus guide'))
#regdir.cnty.interact = data.table(gs_read(gstarget, ws = 'cnty interactive'))
#loadmain()
#load('regdata.Rdata')

# Horserace
horserace = list()
#horserace$cces = list()


# Compute for CCES
regdir = getReg(1.1, regdir.good)$dir
for (var in getReg(1.1, regdir.good)$v.y) {
    for (margtype in c('mam')) {
        for (model in c('logit.fscaled', 'logit.fscaled.whiteHasBS', 'logit.fscaled.whiteNoBS')) {
        #var = getReg(1.1, regdir.good)$v.y[1]
        #margtype = 'mam'
        t = summary(modcces[[model]][[margtype]][[var]])[, c('factor', 'AME', 'p')]
        t$absAME = abs(t$AME)
        t$info = paste(model, var, margtype)
        horserace$cces[[model]][[margtype]][[var]] = merge(regdir[, .(varname.raw, varname.print, table.cat)], t,
                                                  by.x = 'varname.raw', by.y = 'factor')
        }
    }
}
#plot(horserace$cces$mam$cc.TrumpGEVote$AME, horserace$cces$ame$cc.TrumpGEVote$AME)
#lm(horserace$cces$mam$cc.TrumpGEVote$AME~horserace$cces$ame$cc.TrumpGEVote$AME)
#t = merge(horserace$cces$mam$cc.TrumpGEVote, horserace$cces$ame$cc.TrumpGEVote)
#fwrite(t, paste0(respath, 'horserace_cces.csv'))
# CNTY
regdir = getReg(2.1, regdir.good)$dir
for (var in getReg(2.1, regdir.good)$v.y) {
    for (margtype in c('mam')) {
        t = summary(modcnty$ols.fscaled[[margtype]][[var]])[, c('factor', 'AME', 'p')]
        t$absAME = abs(t$AME)
        t$info = paste(var, margtype)
        horserace$cnty[[margtype]][[var]] = merge(regdir[, .(varname.raw, varname.print, table.cat)], t,
                                                  by.x = 'varname.raw', by.y = 'factor')
    }
}

# Glue together, CCES:
sheetout = horserace$cces[[1]][[1]][[1]][0,]
for (var in getReg(1.1, regdir.good)$v.y) {
    for (margtype in c('mam', 'ame')) {
        for (model in c('logit.fscaled', 'logit.fscaled.whiteHasBS', 'logit.fscaled.whiteNoBS')) {
            #var = getReg(2.1, regdir.good)$v.y[2]
                #margtype = 'mam'
                    t = horserace$cces[[model]][[margtype]][[var]]
        sheetout = rbind(t, sheetout)
        #sheetout = merge(sheetout,t,by=c('varname.raw','varname.print','table.cat'))
        }
    }
}

gs_edit_cells(ss = gsresults, ws = 'cces horserace raw', input = sheetout, anchor = "A1", trim = T, verbose = F)

# Glue together, Write to Google Sheets, CNTY
sheetout = horserace$cnty[[1]][[1]][0,]
for (var in getReg(2.1, regdir.good)$v.y) {
    for (margtype in c('mam', 'ame')) {
        #var = getReg(2.1, regdir.good)$v.y[2]
        #margtype = 'mam'
        t = horserace$cnty[[margtype]][[var]]
        sheetout = rbind(t,sheetout)
        #sheetout = merge(sheetout,t,by=c('varname.raw','varname.print','table.cat'))
    }
}
gs_edit_cells(ss = gsresults, ws = 'cnty horserace raw', input = sheetout, anchor = "A1", trim = T, verbose = F)

# Write variables to gsheets list, for easy handling

gs_edit_cells(ss = gsresults, ws = 'cces varlist', input = getReg(1.1, regdir.good)$dir[include == 'x',3:7], anchor = "A1", trim = T, verbose = F)
gs_edit_cells(ss = gsresults, ws = 'cnty varlist', input = getReg(2.1, regdir.good)$dir[include == 'x', 3:7], anchor = "A1", trim = T, verbose = F)

# ================= OLD CODE

    #t = summary(modcces$probit$mam[[var]])
    #t = summary(modcces$probit$ame[[var]])

    #t = merge(t, reg.guide[, .(varname.raw, varname.print)], by.x = 'factor', by.y = 'varname.raw')
    #t$AMEabs = abs(t$AME)
    ##t = t[order(-t$AMEabs, t$p),]
    #t = select(t, varname.print, AMEabs, AME, p, factor)
    #horserace[[var]] = t
#}



#horserace_cces = as.data.table(merge(horserace$cc.TrumpPVote,
                                     #horserace$cc.TrumpGEVote,
                                     #by = 'factor', suffixes = c('.P', '.GE')))


## Compute variables which changed a lot in predictive power between GE and Primaries
#horserace_cces[, AMEdiff := AME.GE - AME.P] # Positive and large if gain in trump vote during GE as compared to primaries
#horserace_cces[, AMEflip := sign(AME.GE) * sign(AME.P)] # Negative if the sign flipped
#horserace_cces = select(horserace_cces, varname.print.P, AME.GE, AME.P,
                         #AMEabs.GE, AMEabs.P, AMEdiff, AMEflip, - varname.print.GE, factor)
#fwrite(horserace_cces, paste0(respath, 'horserace_cces.csv'))

### Countydata
#t = summary(modcnty$ols.fscaled$marg$trumpstr)
#t = filter(t, !grepl('state', factor))
#try(rm(horserace_cnty))
#horserace_cnty = data.frame(factor = t$factor)


#for (var in getReg(2.1, regdir.good)$v.y) {
    #t = summary(modcnty$ols.fscaled$marg[[var]])
    #t = filter(t, !grepl('state', factor))
    #t$AMEabs = abs(t$AME)
    ##t = t[order(-t$AMEabs, t$p),]
    #t = select(t, AMEabs, AME)
    #colnames(t)[colnames(t) == "AMEabs"] = paste0('AMEabs', '_', var)
    #colnames(t)[colnames(t) == "AME"] = paste0('AME', '_', var)
    #horserace_cnty = cbind(horserace_cnty, t)
#}


#horserace_cnty = horserace_cnty[, order(names(horserace_cnty))]
#fwrite(horserace_cnty, paste0(respath, 'horserace_cnty.csv'))
