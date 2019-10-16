import delimited "C:\Users\Zhaochen He\Google Drive\research\proj_010_trump\data\tostata.csv", clear
gen popdensity = pop/geoarealand

replace crashscore4 = crashscore4/pop
gen rustcrashpc = rustcrashppl/pop
gen nworkerstaapc = nworkers/pop

global xmain = "mortucddrugalcpc mortucdsuicide crashscore* rustcrashpc rustcrashpct rustcrashrel nworkerstaapc"
global xctrl = "popdensity edubsp migfbp mignocitp jobuer econmhi econhhpovp demomedage raceblackp raceasianp ethhisn"

qui{
eststo reg1: reg votepct_r_dt $xmain $xctrl i.statefipsn, vce(cluster statefipsn)
eststo reg2: reg drmarg2016 $xmain $xctrl i.statefipsn, vce(cluster statefipsn)
eststo reg3: reg drpmarg2016 $xmain $xctrl i.statefipsn, vce(cluster statefipsn)
eststo reg4: reg drratio2016 $xmain $xctrl i.statefipsn, vce(cluster statefipsn)
eststo reg5: reg pmargdif12 $xmain $xctrl i.statefipsn, vce(cluster statefipsn)
eststo reg6: reg pmargdif8 $xmain $xctrl i.statefipsn, vce(cluster statefipsn)
eststo reg7: reg trumpstrength $xmain $xctrl i.statefipsn, vce(cluster statefipsn)
eststo reg8: reg votepct_d_bs $xmain $xctrl i.statefipsn, vce(cluster statefipsn)
eststo reg9: reg votepct_d_hc $xmain $xctrl i.statefipsn, vce(cluster statefipsn)
}

esttab reg1 reg2 reg3 reg4 reg5 reg6 reg7 reg8 reg9, keep($xmain $xctrl) beta p
