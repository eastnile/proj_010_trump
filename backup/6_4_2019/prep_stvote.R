#setproj(10)
#loadmain()

# Get vote totals ----
varlist = names(select(ccesplus, contains('cc.vote1')))
cces.st.vote = select(ccesplus, statename, varlist, 'cc.commonweight_vv_post')
for (var in varlist) {
    cces.st.vote[, paste0(var) := get(var) * cc.commonweight_vv_post]
}

cces.st.vote = cces.st.vote[, lapply(.SD, sum, na.rm = T), by = 'statename', .SDcols = varlist] # sum by state
cces.st.vote[, cc.vote16.tot := cc.vote16.gop + cc.vote16.dem + cc.vote16.oth] # get tots
cces.st.vote[, cc.vote12.tot := cc.vote12.gop + cc.vote12.dem + cc.vote12.oth]
cces.st.vote = cces.st.vote[!is.na(statename)]

# Rename shit
main.st.vote = select(main, statename, contains('total_'), contains('gop_'), contains('dem_'), contains('oth_'))
for (type in c('total', 'gop', 'dem', 'oth')) {
    for (year in c('08', '12', '16')) {
        names(main.st.vote)[names(main.st.vote) == paste0(type, '_20', year)] = paste0('ge.vote', year, '.', type)
    }
}
names(main.st.vote)[2] = 'ge.vote08.tot'
names(main.st.vote)[3] = 'ge.vote12.tot'
names(main.st.vote)[4] = 'ge.vote16.tot'
varlist = names(select(main.st.vote, contains('ge.vote')))
main.st.vote = main.st.vote[, lapply(.SD, sum, na.rm = T), by = 'statename', .SDcols = varlist] # sum by state
# Fill in missing alaska data (source: wikipedia) ----
main.st.vote[statename == 'Alaska', ge.vote16.tot := 318608]
main.st.vote[statename == 'Alaska', ge.vote16.gop := 163387]
main.st.vote[statename == 'Alaska', ge.vote16.dem := 116454]
main.st.vote[statename == 'Alaska', ge.vote12.tot := 300495]
main.st.vote[statename == 'Alaska', ge.vote12.gop := 164676]
main.st.vote[statename == 'Alaska', ge.vote12.dem := 122640]
main.st.vote[statename == 'Alaska', ge.vote08.tot := 327341]
main.st.vote[statename == 'Alaska', ge.vote08.gop := 193841]
main.st.vote[statename == 'Alaska', ge.vote08.dem := 123594]
for (year in c('08', '12', '16')) {
    main.st.vote[statename == 'Alaska', paste0('ge.vote', year, '.oth')
    := get(paste0('ge.vote', year, '.tot')) - get(paste0('ge.vote', year, '.gop')) - get(paste0('ge.vote', year, '.dem'))]
}

# Compute per capita
for (var in c('vote16')) {
    for (party in c('gop', 'dem', 'oth')) {
        cces.st.vote[, paste0('cc.', var, '.', party, '.pc') := get(paste0('cc.', var, '.', party)) / get(paste0('cc.', var, '.tot'))]
    }
}
for (var in c('vote16')) {
    for (party in c('gop', 'dem', 'oth')) {
        main.st.vote[, paste0('ge.', var, '.', party, '.pc') := get(paste0('ge.', var, '.', party)) / get(paste0('ge.', var, '.tot'))]
    }
}

# Gather data
st.vote = list()
st.vote$ge = list()
st.vote$cc = list()

st.vote$ge$dat = select(main.st.vote, statename, contains('.pc'))
st.vote$cc$dat = select(cces.st.vote, statename, contains('.pc'))

# rename some stuff to be consistent with postest_rerun functions
names(st.vote$ge$dat) = c('statename','vote16.gop.pc','vote16.dem.pc','vote16.oth.pc')
names(st.vote$cc$dat) = c('statename', 'vote16.gop.pc', 'vote16.dem.pc', 'vote16.oth.pc')

save(st.vote,file = 'stvote.Rdata')
#plot(st.vote$cc.vote16.gop.pc,st.vote$ge.vote16.gop.pc)
#abline(a = 0, b = 1)