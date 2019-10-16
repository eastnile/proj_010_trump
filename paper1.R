# Prep
# library(initR)

loadall()

# On race variables
# Correlation of race questions
racevars = c('cc.CC16_422c','cc.CC16_422d','cc.CC16_422e' ,'cc.CC16_422f')
library(corrplot)

racevarnames = c('Not angry about racism','Whites don\'t have advantages','Fearful of other races','Racism is rare')

mat = cor(select(ccesplus, racevars), use = 'pairwise.complete.obs')
rownames(mat) = racevarnames
colnames(mat) = racevarnames
corrplot(mat, method = 'pie', tl.pos = 'lt', tl.cex = 1, tl.srt = 45)


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

# Votes by Racism
z.dat = as.data.table(prop.table(table(ccesplus$cc.raceviewsum, ccesplus$cc.vote16simp), 2))
names(z.dat) = c('race','cand','prop')
ggplot(data = z.dat, aes(x = race, y = prop, fill = cand)) +
    geom_bar(stat = 'identity') +
    guides(fill = guide_legend(title = 'Candidate')) +
    xlab('Racial Views (Higher is Conservative)') + ylab('Percentage of Votes')

# Votes by Racism (stark)
z.dat = as.data.table(prop.table(table(ccesplus$cc.raceviewsum, ccesplus$cc.vote16simp), 1))
names(z.dat) = c('race','cand','prop')
ggplot(data = z.dat, aes(x = race, y = prop, fill = cand)) +
    geom_bar(stat = 'identity') +
    guides(fill = guide_legend(title = 'Candidate')) +
    xlab('Racial Views (Less is Progressive)') + ylab('Percentage of Votes')

# Racism Distribution by Party
ggplot(data = ccesplus, aes(x = cc.raceviewsum)) + #cc.CC16_422c
    #geom_histogram(data = ccesplus[cc.RepDum == 1], fill = 'red', alpha = '0.5') +
    #geom_histogram(data = ccesplus[cc.DemDum == 1], fill = 'blue', alpha = '0.3')
    geom_histogram(data = ccesplus[cc.DemDum == 1], fill = 'blue', alpha = '0.3')
#geom_histogram(data = ccesplus[cc.IndDum == 1,.(cc.raceviewsum)], aes(x=cc.raceviewsum), fill = 'green', alpha = '0.3')

# Racism Breakdown by question
z = ccesplus
z = as.data.table(cbind(table(z$cc.CC16_422c),table(z$cc.CC16_422d),table(z$cc.CC16_422e),table(z$cc.CC16_422f)))
z[,answer:=1:5]
names(z) = c('Not Angry About Racism', 'Whites don\'t have advantages', 'Fearful of other races', 'Racism is rare', 'Answer')
z = melt(z, id.vars = 'Answer')
names(z) = c('Answer','Question','Count')
ggplot(data = z, aes(x = Answer, y = Count, fill = Question)) +
    geom_bar(stat = 'identity') +
    xlab('Responses (1 = Strongly Disagree, 5 = Strongly Agree)') + ylab('Number of Responses')

z = ccesplus[cc.RepDum == 1]
z = as.data.table(cbind(table(z$cc.CC16_422c), table(z$cc.CC16_422d), table(z$cc.CC16_422e), table(z$cc.CC16_422f)))
z[, answer := 1:5]
names(z) = c('Not Angry About Racism', 'Whites don\'t have advantages', 'Fearful of other races', 'Racism is rare', 'Answer')
z = melt(z, id.vars = 'Answer')
names(z) = c('Answer', 'Question', 'Count')
ggplot(data = z, aes(x = Answer, y = Count, fill = Question)) +
    geom_bar(stat = 'identity') +
    xlab('Responses (1 = Strongly Disagree, 5 = Strongly Agree)') + ylab('Number of Responses')

z = ccesplus[cc.IndDum == 1]
z = as.data.table(cbind(table(z$cc.CC16_422c), table(z$cc.CC16_422d), table(z$cc.CC16_422e), table(z$cc.CC16_422f)))
z[, answer := 1:5]
names(z) = c('Not Angry About Racism', 'Whites don\'t have advantages', 'Fearful of other races', 'Racism is rare', 'Answer')
z = melt(z, id.vars = 'Answer')
names(z) = c('Answer', 'Question', 'Count')
ggplot(data = z, aes(x = Answer, y = Count, fill = Question)) +
    geom_bar(stat = 'identity') +
    xlab('Responses (1 = Strongly Disagree, 5 = Strongly Agree)') + ylab('Number of Responses')

z = ccesplus[cc.IndDum == 1 & cc.TrumpGEVote == 1]
z = as.data.table(cbind(table(z$cc.CC16_422c), table(z$cc.CC16_422d), table(z$cc.CC16_422e), table(z$cc.CC16_422f)))
z[, answer := 1:5]
names(z) = c('Not Angry About Racism', 'Whites don\'t have advantages', 'Fearful of other races', 'Racism is rare', 'Answer')
z = melt(z, id.vars = 'Answer')
names(z) = c('Answer', 'Question', 'Count')
ggplot(data = z, aes(x = Answer, y = Count, fill = Question)) +
    geom_bar(stat = 'identity') +
    xlab('Responses (1 = Strongly Disagree, 5 = Strongly Agree)') + ylab('Number of Responses')

z = ccesplus[cc.DemDum == 1]
z = as.data.table(cbind(table(z$cc.CC16_422c), table(z$cc.CC16_422d), table(z$cc.CC16_422e), table(z$cc.CC16_422f)))
z[, answer := 1:5]
names(z) = c('Not Angry About Racism', 'Whites don\'t have advantages', 'Fearful of other races', 'Racism is rare', 'Answer')
z = melt(z, id.vars = 'Answer')
names(z) = c('Answer', 'Question', 'Count')
ggplot(data = z, aes(x = Answer, y = Count, fill = Question)) +
    geom_bar(stat = 'identity') +
    xlab('Responses (1 = Strongly Disagree, 5 = Strongly Agree)') + ylab('Number of Responses')


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

# Population density
plot(main[demo.popdense<100,demo.popdense], main[demo.popdense<100,votepct_r_dt])
map.cnty(main, dr.pmarg.2016, 9)

# Vote difference: 12 vs 16
suppressWarnings(map.cnty(main, pmarg.dif12, 9,title = '2012 vs 2016: Republican Gains'))
ggsave('results/figs/pmargdif_12_16.jpeg', width = 8)
cor(main$pmarg.dif12, main$crashpc)

suppressWarnings(map.cnty(main, demo.medage, 9,title = '2012 vs 2016: Republican Gains'))

