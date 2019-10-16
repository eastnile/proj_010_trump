import delimited "C:\Users\zhaochenhe\Google Drive\research\proj_010_trump\data\tostata.csv", clear
gen popdensity = demopop/geoarealand

replace crashscore4 = crashscore4/demopop
gen rustcrashpc = rustcrashppl/demopop

global xmain = "mortucddrugalcdisc95pdpy mortucdsuicidedisc95pdpy mortucdopioiddisc95pdpy crashscore* rustcrashpc rustcrashpct rustcrashrel taawrksdisc95pcpy"
global xctrl = "popdensity edubsp migfbp mignocitp jobuer econmhi econhhpovp demomedage raceblackp raceasianp ethhisn reppmarch15"

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

global xmain = "mortucddrugalc12pdpy mortucdsuicide12pdpy mortucdopioid12pdpy crashscore* rustcrashpc rustcrashpct rustcrashrel taawrks12pcpy"
global xctrl = "popdensity edubsp migfbp mignocitp jobuer econmhi econhhpovp demomedage raceblackp raceasianp ethhisn reppmarch15"



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

global xmain = "mortucddrugalc8pdpy mortucdsuicide8pdpy mortucdopioid8pdpy crashscore* rustcrashpc rustcrashpct rustcrashrel taawrks8pcpy"
global xctrl = "popdensity edubsp migfbp mignocitp jobuer econmhi econhhpovp demomedage raceblackp raceasianp ethhisn reppmarch15"



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
