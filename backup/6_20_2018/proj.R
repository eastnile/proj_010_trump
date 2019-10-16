path = paste(gdrivepath,'research/proj_010_trump/',sep='')
datpath = paste(path,'data/',sep='')
rawpath = paste(path,'data/raw/',sep='')
respath = paste(path,'results/',sep='')
setwd(path)


pkgs = c('choroplethr','stringr','choroplethrMaps','lubridate')
installif(pkgs)
lib(pkgs)


resetproj = function() {
   reboot()
   setproj(10)
}

loadall = function() {
   load(paste(gdrivepath,'research/data/lookup/USA lookups.Rdata',sep='')
        ,envir=parent.frame())
   load(paste(gdrivepath,'research/data/cntyfacts/geoarea.Rdata',sep='')
        ,envir=parent.frame())
   load(paste(gdrivepath,'research/proj_010_trump/data/acs5cnty.Rdata',sep='')
        ,envir=parent.frame())
   load(paste(gdrivepath,'research/proj_010_trump/data/cdc_mort.Rdata',sep='')
        ,envir=parent.frame())
   load(paste(gdrivepath,'research/proj_010_trump/data/crash.Rdata',sep='')
        ,envir=parent.frame())
   load(paste(gdrivepath,'research/proj_010_trump/data/primaries.Rdata',sep='')
        ,envir=parent.frame())
   load(paste(gdrivepath,'research/proj_010_trump/data/taa.Rdata',sep='')
        ,envir=parent.frame())
   load(paste(gdrivepath,'research/proj_010_trump/data/genelec.Rdata',sep='')
        ,envir=parent.frame())
   load(paste(gdrivepath,'research/proj_010_trump/data/john.Rdata',sep='')
        ,envir=parent.frame())
}


loadmain = function() {
   load(paste(datpath,'main.Rdata',sep=''),envir=parent.frame())
}

source('fCntyToolbox.R')
