# Prep
setproj(10)
loadall()

# Sec unknown

# Summary of votes by racial attitude
ccesplus$cc.vote16simp = NULL
ccesplus[cc.vote16 == 1, cc.vote16simp := 1]
ccesplus[cc.vote16 == 2, cc.vote16simp := 2]
ccesplus[cc.vote16 > 2, cc.vote16simp := 3]
ccesplus$cc.vote16simp = factor(ccesplus$cc.vote16simp)
levels(ccesplus$cc.vote16simp) = c('Trump', 'Hillary', 'Other')
ccesplus$cc.raceviewsimp = NULL
ccesplus[, cc.raceviewsimp := ceiling(cc.raceviewsum)]
table(ccesplus$cc.raceviewsimp)

# Racism distribution
z.dat = as.data.table(prop.table(table(ccesplus$cc.raceviewsum, ccesplus$cc.vote16simp), 2))
names(z.dat) = c('race','cand','prop')
ggplot(data = z.dat, aes(x = race, y = prop, fill = cand)) +
    geom_bar(stat = 'identity') +
    guides(fill = guide_legend(title = 'Candidate')) +
    xlab('Racial Views (Less is Progressive)') + ylab('Percentage of Votes')

# Support for each candidate
z.dat = as.data.table(prop.table(table(ccesplus$cc.raceviewsimp, ccesplus$cc.vote16simp), 2))
names(z.dat) = c('race', 'cand', 'prop')
ggplot(data = z.dat, aes(x = factor(1), y = prop, fill = race)) +
    geom_bar(stat = 'identity', color = "black", width = 1) +
    coord_polar(theta = 'y') +
    #geom_text(aes(label = round(prop * 100, 1)), position = position_stack(vjust = 0.5)) +
    facet_wrap(~cand) + scale_fill_brewer(palette = 'RdYlGn', direction = -1, aesthetics = "fill") +
    theme(axis.line = element_blank(), axis.text = element_blank(), axis.ticks = element_blank()) +
    guides(fill = guide_legend(title = 'Racial Views')) +
    xlab(element_blank()) + ylab('Percentage of Votes')


# Sec: Methods

# Tale of 3 cities:
ind_lookup = j2jschema$j2jod$industry[ind_level == 2]
ind_lookup[industry == 56, label := 'Business Support, Waste, and Remediation']
qwi = merge(wrkdata, ind_lookup, by.x = 'industry', by.y = 'industry', all.x = T)
# Boston:
plot.allind(qwi,'EmpTotalSm',25,025,title='Boston, MA (Suffolk Co.)',
            x=NULL,y='Persons Employed',shape='Industry',color='Industry')
ggsave('results/figs/indplot_boston.jpeg',width=8,height = 5)

# Detroit:
plot.allind(qwi,'EmpTotalSm',26,163,title='Detroit, MI (Wayne Co.)',
            x=NULL,y='Persons Employed',shape='Industry',color='Industry')
ggsave('results/figs/indplot_detroit.jpeg', width = 8, height = 5)

# Galesburg:
plot.allind(qwi,'EmpTotalSm',17,95,title='Galesburg, IL (Knox Co.)',
            x=NULL,y='Persons Employed',shape='Industry',color='Industry')
ggsave('results/figs/indplot_galesburg.jpeg', width = 8, height = 5)

# Crash Scores
cities = data.frame(statefipsn = c(17,26,25), cntyfipsn = c(95,163,25))
cities = as.data.table(merge(cities,crashcnty,all=F))
citiesabs = cities[,.(statefipsn,cntyfipsn,crashppl,crashpc,rustppl,rustpc)]
citiespct = cities[,.(statefipsn,cntyfipsn,crashppl.rk,crashpc.rk,rustppl.rk,rustpc.rk)]
                
# Show crash scores on a map
suppressWarnings(map.cnty(crashcnty, crashpc.rk, 9,title = 'Job Decline (All Industries), Percentile Rank'))
ggsave('results/figs/crashpc_usa.jpeg', width = 8)
suppressWarnings(map.cnty(crashcnty, rustpc.rk, 9, title = 'Job Decline (Manuf. Only), Percentile Rank'))
ggsave('results/figs/rustpc_usa.jpeg', width = 8)
suppressWarnings(map.cnty(crashcnty, crashppl, 9, title = 'Job Decline (All Industries), Total Persons'))
ggsave('results/figs/crashppl_usa.jpeg', width = 8)
suppressWarnings(map.cnty(crashcnty, rustppl, 9, title = 'Job Decline (Manuf. Only), Total Persons'))
ggsave('results/figs/rustppl_usa.jpeg', width = 8)