loadmain()

detach(main)

## Examine mortality data
cor(select(main,matches('mort\\..*12\\.pdpy')),use='pairwise')
cor(select(main,matches('mort\\..*8\\.pdpy')),use='pairwise')
cor(select(main,matches('mort\\..*disc95\\.pdpy')),use='pairwise')


## Distributions of each variable
hist(select(main,matches('mort\\..*12\\.pdpy')))
hist(select(main,matches('mort\\..*8\\.pdpy')))
hist(select(main,matches('mort\\..*disc95\\.pdpy')))
# These look pretty similar; roughly lognormal

## Cross County Maps
# Absolute
map.cnty(main,mort.ucd.drugalc.disc95.pdpy,0)
map.cnty(main,mort.ucd.opioid.disc95.pdpy,0)
map.cnty(main,mort.ucd.suicide.disc95.pdpy,0)
# 1/9 - centiles
map.cnty(main,mort.ucd.drugalc.disc95.pdpy,9)
map.cnty(main,mort.ucd.opioid.disc95.pdpy,9)
map.cnty(main,mort.ucd.suicide.disc95.pdpy,9)


a=map.cnty(main,mort.ucd.suicide.disc95.pdpy,9)
main[,demo.popdenseinv := 1/demo.popdense]
b=map.cnty(main,demo.popdenseinv,9)
double_map(a,b)
