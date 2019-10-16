# Set paths
path = paste(gdrivepath,'research/proj_010_trump/',sep='')
datpath = paste(path,'data/',sep='')
rawpath = paste(path,'data/raw/',sep='')
respath = paste(path,'results/',sep='')
setwd(path)

# Load libraries
pkgs = c('choroplethr','stringr','choroplethrMaps','lubridate','stargazer','ggplot2','googlesheets'
         ,'knitr')
installif(pkgs)
lib(pkgs)

# Log into google sheets, store sheet ids
gs_ls() 
gskey.varguide = '1F9WgoFMqd0yHVtc7ux1mAtntdOhAx6igw9ylo-PGxGs'

# Store custom functions
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
}


loadmain = function() {
   load(paste(datpath,'main.Rdata',sep=''),envir=parent.frame())
   #load(paste(gdrivepath,'research/proj_010_trump/data/cces.Rdata',sep='')
   #     ,envir=parent.frame())
   load(paste(datpath,'cces.Rdata',sep=''),envir=parent.frame())
}

gsgetregvars = function() {
   gsdat = data.table(gs_read(gs_key(gskey.varguide),ws='ccesplus guide'))
   return(gsdat[!is.na(include)&is.na(omit.dummy)&is.na(exclude),.(varname.raw,tags,include)])
}

# Other stuff

source('fCntyToolbox.R')
