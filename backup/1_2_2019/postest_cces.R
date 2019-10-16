# Compute Marginal Effects
#system.time({
#udat = regdata %>% summarise_all(funs(mean(.,na.rm=T)))
#for (var in v.y) {
  ##var = 'cc.TrumpGEVote'
  #mod$probit$marg[[var]] = margins(mod$probit$m[[var]],variables=v.x)
  #mod$probit.fscaled$marg[[var]] = margins(mod$probit.fscaled$m[[var]],variables=v.x)
  ## mod$probit$umarg[[var]] = margins(mod$probit$m[[var]],data=udat)
  ## mod$probit.fscaled$umarg[[var]] = margins(mod$probit$m[[var]],data=udat)
  #}
#})
#save(mod,file='reg_cces.Rdata')
load(file='reg_cces.Rdata')
# Horserace

library(margins)

gsdat = data.table(gs_read(codebook.gs, ws = 'regdir'))
regdir = gsdat[!is.na(include) & is.na(exclude), .(regid, regdscr, varname.raw, varname.print, table.cat, table.order1, table.order2, exclude, include, flag1, flag2)]
reg.guide = regdir[regid == 1.1]

# Summarize rankings for AME, thus creating the horserace
horserace = list()
for (var in c('cc.TrumpGEVote', 'cc.TrumpPVote')) {
    t = summary(mod$probit.fscaled$marg[[var]])
    t = merge(t, reg.guide[, .(varname.raw, varname.print)], by.x = 'factor', by.y = 'varname.raw')
    t$AMEabs = abs(t$AME)
    t = t[order(-t$AMEabs, t$p),]
    t = select(t, varname.print,AMEabs, AME,p,factor)
    horserace[[var]] = t
}
horseraceprobit = as.data.table(merge(horserace$cc.TrumpPVote, horserace$cc.TrumpGEVote, by = 'factor', suffixes = c('.P', '.GE')))


# Compute variables which changed a lot in predictive power between GE and Primaries
horseraceprobit[, AMEdiff := AME.GE - AME.P] # Positive and large if gain in trump vote during GE as compared to primaries
horseraceprobit[, AMEflip := sign(AME.GE) * sign(AME.P)] # Negative if the sign flipped

horseraceprobit = select(horseraceprobit, varname.print.P, AME.GE, AME.P,
                         AMEabs.GE,AMEabs.P, AMEdiff, AMEflip, - varname.print.GE, factor)
fwrite(horseraceprobit, paste0(respath, 'horseraceprobit.csv'))





#cplot(mod$olsfe$m$cc.TrumpPVote,x='cc.Age',what='prediction')
