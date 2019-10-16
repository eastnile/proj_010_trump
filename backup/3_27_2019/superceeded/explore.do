* Explore mortality data
* Correlation of mortality measures
corr(mort*disc95pdpy)

* Cross county distribution of measures, all years discounted
hist(mortucddrugalcdisc95pdpy), saving(a,replace)
hist(mortucdopioiddisc95pdpy), saving(b,replace)
hist(mortucdsuicidedisc95pdpy), saving(c,replace)
graph combine a.gph b.gph c.gph

* Cross county distribution of measures, since 2008
hist(mortucddrugalc8pdpy), saving(a,replace)
hist(mortucdopioid8pdpy), saving(b,replace)
hist(mortucdsuicide8pdpy), saving(c,replace)
graph combine a.gph b.gph c.gph


