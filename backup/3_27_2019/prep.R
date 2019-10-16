## Import/Prep Individual Datasets:
# source('prep_acs.R')
# source('prep_relig.R')
# source('prep_cdc.R')
# source('prep_john.R')
# source('prep_politics.R')
# source('prep_taa.R')
# source('prep_crash.R')
# source('prep_cces.R')

# Reload relevant datasets
load(paste0(gdrivepath,'research/data/lookup/USA lookups.Rdata'))
load(paste0(gdrivepath,'research/data/cntyfacts/geoarea.Rdata'))
load(paste0(gdrivepath,'research/data/cntyfacts/pop.Rdata'))
load(paste0(datpath,'acs5cnty.Rdata'))
load(paste0(datpath,'cdc_mort.Rdata'))
load(paste0(datpath,'crash.Rdata'))
load(paste0(datpath,'primaries.Rdata'))
load(paste0(datpath,'taa.Rdata'))
load(paste0(datpath,'genelec.Rdata'))
load(paste0(datpath,'john.Rdata'))
load(paste0(datpath,'relig.Rdata'))
load(paste0(datpath,'main.Rdata'))
load(paste0(datpath,'cces.Rdata'))

# Giant Merge
acs5cnty = acs5 %>% group_by(statefipsn,cntyfipsn) %>% summarize_at(vars(-statefipsn,-cntyfipsn,-year), mean)
main = cnty.lookup %>% 
  merge(y=cdc.mort.cnty,by=c('statefipsn','cntyfipsn'),all.x=T)  %>%
  merge(y=crashcnty,by=c('statefipsn','cntyfipsn'),all.x=T) %>% 
  merge(y=primaries.cnty,by=c('statefipsn','cntyfipsn'),all.x=T) %>% 
  merge(y=cntyfacts.geoarea,by=c('statefipsn','cntyfipsn'),all.x=T) %>% 
  merge(y=acs5cnty,by=c('statefipsn','cntyfipsn'),all.x=T) %>%
  merge(y=taacnty,by=c('statefipsn','cntyfipsn'),all.x=T) %>%
  merge(y=genelec,by=c('statefipsn','cntyfipsn'),all.x=T) %>%
  merge(y=john,by=c('statefipsn','cntyfipsn'),all.x=T) %>%
  merge(y=relig,by=c('statefipsn','cntyfipsn'),all.x=T)

main[,demo.popdense := demo.pop/geo.area.land]
main[,econ.mhi := econ.mhi/1000]

# Feature Scaling
isdum = sapply(main, function(x) { all(x %in% c(0:1, NA)) })
isnumeric = sapply(main, is.numeric)
norescale = isdum | !isnumeric
t = as.data.frame(main)
main.fscaled = as.data.frame(main)
main.fscaled[!norescale] = scale(t[!norescale], center = F)
# Save main county level data 
path = paste(gdrivepath,'research/proj_010_trump/data/main.Rdata',sep='')
save(main,main.fscaled, file = path)

# Merge main county level data and cces to create "ccesplus"
load(paste(datpath,'main.Rdata',sep='')) # Load county level data
ccesplus = merge(x = cces, y = main, by.x = 'cc.countyfips', by.y = 'fipsn.x', all.x=T)
path = paste(gdrivepath, 'research/proj_010_trump/data/ccesplus.Rdata', sep = '')
# Feature Scaling
isdum = sapply(ccesplus, function(x) { all(x %in% c(0:1, NA)) })
isnumeric = sapply(ccesplus, is.numeric)
norescale = isdum | !isnumeric
t = as.data.frame(ccesplus)
ccesplus.fscaled = as.data.frame(ccesplus)
ccesplus.fscaled[!norescale] = scale(t[!norescale], center = F)
save(ccesplus, ccesplus.fscaled, file = path)



# ==========================================================================================================
# # G-Sheets Processing: County Level Data
# Generate Metadata

#t = sapply(main, function(x) sum(!is.na(x)) / length(x))
#meta.cnty = data.table(varname.raw = names(t), pctobs = t)
#gs_edit_cells(ss = gstarget, ws = 'cnty raw', input = meta.cnty, trim = F, verbose = F) #takes awhile



# # G-Sheets Processing: CCES Plus
# # Write raw metadata to google sheets
# gsKey = '1F9WgoFMqd0yHVtc7ux1mAtntdOhAx6igw9ylo-PGxGs'
# gstarget = gs_key(gsKey)
# varguide = data.table(vname = names(ccesplus))
# cces.meta$vname = paste('cc.',cces.meta$vname,sep='')
# varguide = merge(varguide,cces.meta[1:3],all.x=T,sort=F,by='vname')
# # varguide[,var.id:=.I]
# setcolorder(varguide,c('vname','descr','cat'))
# gs_edit_cells(ss = gstarget, ws = 'ccesplus raw', input = varguide,trim =F,verbose=F) #takes awhile
# 
# # Get long list of relevant variables from hand-reviewed gsheet (ccesplus guide) 
# # and compute correlations
# gsdat = data.table(gs_read(gs_key(gsKey),ws='ccesplus guide'))
# datvars = gsdat[!is.na(flag1),varname.raw]
# corguide = data.frame(varname.raw = datvars, cortrump.p = '',cortrump.ge = '',stringsAsFactors = F)
# for (i in 1:length(datvars)) {
#   x = select(ccesplus,datvars[i])
#   corguide[i,'cortrump.p'] = 
#     as.character(try(round(cor(x,ccesplus$cc.TrumpPVote,use='pairwise'),3),silent=T))
#   corguide[i,'cortrump.ge'] =
#     as.character(try(round(cor(x,ccesplus$cc.TrumpGEVote,use='pairwise'),3),silent=T))
#   corguide[i,'numobs'] = round(nrow(x[!is.na(get(datvars[i])),]),2)
#   corguide[i,'pctobs'] = round(nrow(x[!is.na(get(datvars[i])),])/nrow(x),2)
# }
# 
# # Write results to Google Sheets and csv
# # to.gs = merge(varguide,corguide,all.x=T,sort=F)
# #fwrite(to.gs,paste0(datpath,'cces_corr.csv'))
# #try(gs_ws_delete(ss = gstarget, ws = 'fromR'))
# gs_edit_cells(ss = gstarget, ws = 'corr from R', input = corguide,trim =F,verbose=F)


# Export to csv
# fwrite(main,file = paste(datpath,'tostata.csv',sep=''))
     