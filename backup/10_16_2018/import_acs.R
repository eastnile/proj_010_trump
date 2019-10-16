# Globals
installif(c('htmltab','googlesheets','httr'))
lib(c('htmltab','googlesheets','httr'))
source(paste(gdrivepath,"research/data/censusapi/getcensus_functions.R",sep=""))
Sys.setenv(CENSUS_KEY='f45bed1e85ca90e49e17730d7a282cec8e54a98d')
gsKey = '1uMPb0YdaZ6Vy7Aim21YMNfMzUCy8L-Zeon8zVhcXGjU'

# Get list of all AC5 datasets on the census API (various years)

apiguide=data.table(htmltab(doc='https://api.census.gov/data.html',which=1))
acs5url=apiguide[regexpr('acs5/profile',`API Base URL`) > 0,.(`API Base URL`)]
acs5url[,year:=as.integer(substr(`API Base URL`,regexpr('data/',`API Base URL`)+5,regexpr('data/',`API Base URL`)+8))]
acs5url[,urlsnip:=substr(`API Base URL`,regexpr('data/',`API Base URL`)+5,nchar(`API Base URL`))]
acs5url = acs5url[!duplicated(acs5url$year),]
# Upon first login, need to authenticate:
gs_ls()

# Read list of requested variables from google sheets
require(googlesheets)
gsdat = data.table(gs_read(gs_key(gsKey)))
varguide = gsdat[!is.na(flag),]

# Pull data
acs5 = data.table()
for (i in 1:length(acs5url$urlsnip)) {
   t=data.table(getCensus(name=acs5url$urlsnip[i],
                          vars=varguide$name, 
                          region=c("county:*"), regionin = c("state:*")))
   t[,year:=acs5url$year[i]]
   acs5 = rbind(acs5,t)
}
# Rename variables
setnames(acs5,varguide$name,varguide$easyname)
# Merge with cnty lookup
load(paste(gdrivepath,'research/data/lookup/USA lookups.Rdata',sep=''))
acs5[,fipsstr:=paste(state,county,sep='')]
acs5[,c('state','county'):=NULL]
acs5 = merge(cnty.lookup,acs5,by='fipsstr',all.x=T)
acs5 = acs5[,9:ncol(acs5)]
# Save file
path = paste(gdrivepath,'research/proj_010_trump/data/acs5cnty.Rdata',sep='')
save(acs5,file=path)
