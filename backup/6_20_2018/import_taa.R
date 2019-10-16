require(lubridate)
require(data.table)

#Load lookups
load(paste(gdrivepath,"research/data/lookup/USA lookups.RData",sep=""))

#Read in data
path = "research/proj_010_trump/data/raw/Public Citizen TAA Data 2018.csv"
types = c("character","character","character","character","character","character",
          "character","character","character","integer","character","character")
varnames = c("company","city","stateabr","district","cntynameorig","metro","product","petitioner",
             "layoffdate","nworkers","cause","country")
data = data.table(read.csv(paste(gdrivepath,path,sep=""), header=TRUE, colClasses=types, col.names=varnames))
# Clean up county name to prepare for merge with lookup
cntymatch = data$cntynameorig
cntymatch = gsub(" County","",cntymatch)
cntymatch = gsub(" Parish","",cntymatch)
cntymatch = gsub(" and Borough","",cntymatch)
cntymatch = gsub(" Borough","",cntymatch)
cntymatch = gsub(" Municipality","",cntymatch)
cntymatch = gsub(" Census Area","",cntymatch)
cntymatch = gsub("[[:punct:]]", "", cntymatch)
cntymatch = gsub(" ", "", cntymatch)
cntymatch = tolower(cntymatch)
data = cbind(data,cntymatch)

# Merge with lookup
data = merge(data,cnty.lookup,by=c("cntymatch","stateabr"),X.all=TRUE)

# Create county level sums
taaCnty = data[,.(nworkers=sum(nworkers),npetitions=.N),by=.(statefipsn,cntyfipsn)]
taaAlldata = data
rm(data)

# Save data
path = "research/proj_010_trump/data/"
save(taaAlldata, taaCnty, file = paste(gdrivepath,path,"taa.Rdata",sep=""))

# Graph it
require(choroplethr)
require(choroplethrMaps)
plotdata = data.table(region=as.numeric(taaCnty$fips),value=taaCnty$nworkers)
county_choropleth(plotdata)