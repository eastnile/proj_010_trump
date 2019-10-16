# Set paths
projpath = paste(gdrivepath,'research/proj_010_trump/',sep='')
datpath = paste(projpath,'data/',sep='')
rawpath = paste(projpath,'data/raw/',sep='')
respath = paste(projpath,'results/',sep='')
setwd(projpath)

# Load libraries
pkgs = c('data.table','plyr','dplyr','choroplethr','stringr','choroplethrMaps',
         'lubridate','stargazer','ggplot2','googlesheets',
         'knitr','fastDummies')
installif(pkgs)
lib(pkgs)

# Google sheets keys
# varguide
gsKey = '1F9WgoFMqd0yHVtc7ux1mAtntdOhAx6igw9ylo-PGxGs'
codebook.gs = gs_key(gsKey)

# Log into google sheets, store sheet ids
gs_ls() 
gskey.varguide = '1F9WgoFMqd0yHVtc7ux1mAtntdOhAx6igw9ylo-PGxGs'

# Custom Project Functions
resetproj = function() {
   reboot()
   setproj(10)
}

loadall = function() {
   load(paste(gdrivepath,'research/data/lookup/USA lookups.Rdata',sep='')
        ,envir=parent.frame())
   load(paste(gdrivepath,'research/data/cntyfacts/geoarea.Rdata',sep='')
        ,envir=parent.frame())
   load(paste(gdrivepath,'research/data/cntyfacts/pop.Rdata',sep='')
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
   load(paste(gdrivepath,'research/proj_010_trump/data/relig.Rdata',sep='')
        ,envir=parent.frame())
   load(paste(gdrivepath,'research/proj_010_trump/data/main.Rdata',sep='')
        ,envir=parent.frame())
   load(paste(gdrivepath,'research/proj_010_trump/data/cces.Rdata',sep='')
        ,envir=parent.frame())
   load(paste(gdrivepath,'research/proj_010_trump/data/ccesplus.Rdata',sep='')
        ,envir=parent.frame())
}

loadmain = function() {
   load(paste(datpath,'main.Rdata',sep=''),envir=parent.frame())
   load(paste(datpath,'ccesplus.Rdata',sep=''),envir=parent.frame())
}


# Other custom functions
source('fcustom.R')
