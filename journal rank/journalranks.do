use journal_rank_econ.dta, clear
keep rank sourceid title
destring(rank), replace force
rename rank rank_econ
save journal_econ_premerge.dta, replace

use journal_rank_psci.dta, clear
keep rank sourceid title
destring(rank), replace force
rename rank rank_psci
save journal_psci_premerge.dta, replace

merge sourceid using journal_econ_premerge.dta, sort

* 53 journals in common
keep if _m == 3
sort rank_econ
