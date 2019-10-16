setproj(10)
loadmain()
gsKey = '1F9WgoFMqd0yHVtc7ux1mAtntdOhAx6igw9ylo-PGxGs'
gstarget = gs_key(gsKey)

# require(googlesheets)
# gs_ls()  # Upon first login, need to authenticate

# Write raw variable list to Google Sheets
varguide = data.table(vname = names(ccesplus))
cces.meta$vname = paste('cc.',cces.meta$vname,sep='')
varguide = merge(varguide,cces.meta[1:3],all.x=T,sort=F,by='vname')
# varguide[,var.id:=.I]
setcolorder(varguide,c('var.id','vname','descr','cat'))

gs_edit_cells(ss = gstarget, ws = 'ccesplus raw', input = varguide,trim =F,verbose=F) #takes awhile

# Get long list of relevant variables from hand-reviewed gsheet (ccesplus guide) and compute corr
gsdat = data.table(gs_read(gs_key(gsKey),ws='ccesplus guide'))
datvars = gsdat[!is.na(flag1),varname.raw]
corguide = data.frame(varname.raw = datvars, cortrump.p = '',cortrump.ge = '',stringsAsFactors = F)
for (i in 1:length(datvars)) {
   x = select(ccesplus,datvars[i])
   corguide[i,'cortrump.p'] = 
      as.character(try(round(cor(x,ccesplus$cc.TrumpPVote,use='pairwise'),3),silent=T))
   corguide[i,'cortrump.ge'] =
      as.character(try(round(cor(x,ccesplus$cc.TrumpGEVote,use='pairwise'),3),silent=T))
   corguide[i,'numobs'] = round(nrow(x[!is.na(get(datvars[i])),]),2)
   corguide[i,'pctobs'] = round(nrow(x[!is.na(get(datvars[i])),])/nrow(x),2)
}

# Write results to Google Sheets and csv
# to.gs = merge(varguide,corguide,all.x=T,sort=F)
#fwrite(to.gs,paste0(datpath,'cces_corr.csv'))
#try(gs_ws_delete(ss = gstarget, ws = 'fromR'))
gs_edit_cells(ss = gstarget, ws = 'corr from R', input = corguide,trim =F,verbose=F)