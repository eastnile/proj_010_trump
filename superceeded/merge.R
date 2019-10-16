# Load data
setproj(10)
loadall()

acs5cnty = acs5 %>% group_by(statefipsn,cntyfipsn) %>% summarize_at(vars(-statefipsn,-cntyfipsn,-year), mean)

# Giant Merge
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
main[,econ.mhi:=econ.mhi/1000]

# Save data 
path = paste(gdrivepath,'research/proj_010_trump/data/main.Rdata',sep='')
save(main, file = path)

# Export to data
fwrite(main,file = paste(datpath,'tostata.csv',sep=''))






