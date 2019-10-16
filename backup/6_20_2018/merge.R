source(paste(gdrivepath,'research/proj_010_trump/fCntyToolbox.R',sep=''))

# Load data
loadall()

# Construct yearly vars






# Giant Merge
wrkdata = cnty.lookup %>% 
merge(y=cdc.mort[year==2011],by=c('statefipsn','cntyfipsn'),all.x=T)  %>%
merge(y=crashcnty,by=c('statefipsn','cntyfipsn'),all.x=T) %>% 
merge(y=primaries.cnty,by=c('statefipsn','cntyfipsn'),all.x=T) %>% 
merge(y=cntyfacts.geoarea,by=c('statefipsn','cntyfipsn'),all.x=T) %>% 
merge(y=acs5[year==2011],by=c('statefipsn','cntyfipsn'),all.x=T) %>%
merge(y=taaCnty,by=c('statefipsn','cntyfipsn'),all.x=T) %>%
merge(y=crashrust,by=c('statefipsn','cntyfipsn'),all.x=T) %>%
merge(y=genelec,by=c('statefipsn','cntyfipsn'),all.x=T) %>%
merge(y=john,by=c('statefipsn','cntyfipsn'),all.x=T)


# Per capita values
gen.pc(wrkdata,c('nworkers','npetitions'))

# Save data 

path = paste(gdrivepath,'research/proj_010_trump/data/main.Rdata',sep='')
save(wrkdata, file = path)

# Export to data
fwrite(wrkdata,file = paste(gdrivepath,'research/proj_010_trump/data/tostata.csv',sep=''))






