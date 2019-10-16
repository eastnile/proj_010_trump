use "C:\Users\zhaochenhe\Google Drive\research\proj_010_trump\data\raw\U.S. Religion Census Religious Congregations and Membership Study, 2010 (County File).DTA",clear 

keep fips - POP2010 *adh
keep fips - POP2010 totadh evanadh bprtadh mprtadh cathadh orthadh othadh budmadh budtadh budvadh ldsadh hniadh hnpradh hnradh hnttadh mslmadh nondadh ojudadh

gen majprtadh = evanadh + bprtadh + mprtadh
label var majprtadh "major protestant denominations" 

gen majchradh =  evanadh + bprtadh + mprtadh + cathadh + orthadh

label var majchradh "major christian denominations" 

gen budadh = budmadh + budtadh + budvadh

label var budadh "buddhists" 

gen hindadh = hniadh + hnpradh + hnradh + hnttadh 

label var hindadh "hindus" 

keep totadh evanadh cathadh orthadh othadh ldsadh mslmadh ojudadh majprtadh majchradh budadh hindadh stcode cntycode 

order stcode cntycode

rename stcode statefipsn
rename cntycode cntyfipsn

saveold "C:\Users\zhaochenhe\Google Drive\research\proj_010_trump\data\relig.dta", replace 
