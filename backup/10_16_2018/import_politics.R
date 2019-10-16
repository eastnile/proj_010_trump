#Load lookups
load(paste(gdrivepath,'research/data/lookup/USA lookups.RData',sep=''))

#Read in data
path = paste(gdrivepath,'research/proj_010_trump/data/raw/primary_results.csv', sep='')
#data = data.table(read.csv(paste(gdrivepath,path,sep='')))
types = c('character','character','character','character','character','character',
          'integer','double','integer','factor')
varnames = c('statename','stateabr','cntyname','id','party','candidate','votes','votespct','idlength','nopolitico')
primaries = data.table(read.csv(path, header=TRUE, colClasses=types, col.names=varnames))

# (a) Drop counties with no data from politico; these counties can't be matched by FIPS and generally, don't have primary data broken down by county. This is usually because the state in question uses Caucauses, not primaries.
primaries=primaries[nopolitico==0]

# (b) Of the remaining states, some have valid FIPS codes and some don't. Those with idlength >5 have invalid FIPS codes, and need to be matched by county name.
primaries[,id:=gsub('[[:punct:]]','',id)]
primaries[,idvalid := 0]
primaries[idlength>0 & idlength<=5,idvalid := 1]
primaries[idvalid == 1,cntyfipsn := as.integer(substr(id,nchar(id)-2,nchar(id)))]
primaries[idvalid == 1,statefipsn := as.integer(substr(id,1,nchar(id)-3))]

# Clean up county names and create easymatch name
cntyname = primaries$cntyname
cntyname = gsub(" County","",cntyname)
cntyname = gsub(" Parish","",cntyname)
cntyname = gsub(" and Borough","",cntyname)
cntyname = gsub(" Borough","",cntyname)
cntyname = gsub(" Municipality","",cntyname)
cntyname = gsub(" Census Area","",cntyname)
cntymatch = gsub("[[:punct:]]", "", cntyname)
cntymatch = gsub(" ", "", cntymatch)
cntymatch = tolower(cntymatch)
primaries = cbind(primaries,cntymatch)

# Match county names
t.primaries.matchfips = primaries[idvalid==1,.(party,candidate,votes,cntyfipsn,statefipsn)]
t.primaries.matchcnty = primaries[idvalid==0,.(party,candidate,votes,stateabr,cntymatch)]
t.primaries.matchcnty = merge(t.primaries.matchcnty,cnty.lookup,by=c('stateabr','cntymatch'),all.x=TRUE)
#t.primaries.matchcnty[is.na(cntyfipsn)]
t.primaries.matchcnty = t.primaries.matchcnty[,.(party,candidate,votes,cntyfipsn,statefipsn)]
t.primaries = rbind(t.primaries.matchfips,t.primaries.matchcnty)
primaries = merge(t.primaries,cnty.lookup,by=c('statefipsn','cntyfipsn'),all.x=TRUE)

# Compute additional numbers and clean up factor variables
primaries[,totvote:=sum(votes),by=.(party,statefips,cntyfips)]
primaries=primaries[totvote>0]
primaries[,votepct:=votes/totvote]
primaries$party=tolower(substr(primaries$party,1,1))
t.names = unique(primaries$candidate)
t.1 = strsplit(t.names,' ')
t.2 = lapply(t.1,substr,start=1,stop=1)
t.3 = tolower(unlist(lapply(t.2,paste,collapse='')))
dict = setNames(t.3,t.names)
primaries$candidate = dict[unlist(primaries$candidate)]


primaries[,ncand:=.N,by=.(statefipsn,cntyfipsn,party)]
primaries[,rankvotes:=rank(-votes,ties.method='first'),by=.(statefipsn,cntyfipsn,party)]

winner=primaries[rankvotes==1&party=='r',.(statefipsn,cntyfipsn,candidate,votepct)]
setnames(winner,c('candidate','votepct'),c('winner','winner_votepct'))
runnerup = primaries[rankvotes==2&party=='r',.(statefipsn,cntyfipsn,candidate,votepct)]
setnames(runnerup,c('candidate','votepct'),c('runnerup','runnerup_votepct'))
trumpvote = primaries[candidate=='dt',.(statefipsn,cntyfipsn,votepct)]
setnames(trumpvote,c('votepct'),c('dt_votepct'))

trumpstr = winner %>% merge(runnerup) %>% merge(trumpvote)
trumpstr[winner=='dt',trumpstr:=winner_votepct-runnerup_votepct]
trumpstr[winner!='dt',trumpstr:=dt_votepct-winner_votepct]

ncand = primaries[,.(ncand=max(ncand)),by=.(statefipsn,cntyfipsn,party)]

# Big reshape
primaries = primaries[,.(statefipsn,cntyfipsn,party,candidate,votes,totvote,votepct)]

trumpstr = merge(trumpstr,ncand[party=='r'])
trumpstr[,trumpstrnorm := trumpstr*ncand]
# primaries.d = primaries[party=='d']
# primaries.r = primaries[party=='r']
# primaries.d.cnty = dcast(primaries.d,statefipsn+cntyfipsn~candidate,value.var=c('votes','totvote','votepct','ncand'))
# primaries.r.cnty = dcast(primaries.r,statefipsn+cntyfipsn~candidate,value.var=c('votes','totvote','votepct','ncand'))
primaries.cnty = dcast(primaries,statefipsn+cntyfipsn~party+candidate,value.var=c('votes','totvote','votepct'))
primaries.cnty = merge(primaries.cnty,trumpstr[,.(statefipsn,cntyfipsn,trumpstr,trumpstrnorm)])

# Save
path = paste(gdrivepath,'research/proj_010_trump/data/primaries.Rdata',sep='')
save(primaries,primaries.cnty,file=path)

# Import general elections data
path = paste(gdrivepath,'research/proj_010_trump/data/raw/US_County_Level_Presidential_Results_08-16.csv', sep='')

#data = data.table(read.csv(paste(gdrivepath,path,sep='')))
types = c('character','character','character','character','character','character',
          'integer','double','integer','factor')
varnames = c('statename','stateabr','cntyname','id','party','candidate','votes','votespct','idlength','nopolitico')
primaries = data.table(read.csv(path, header=TRUE, colClasses=types, col.names=varnames))

genelec = fread(path)
for (year in c(2008,2012,2016)) {
   genelec[,paste('dr.ratio.',year,sep='') := get(paste('dem_',year,sep=''))/get(paste('gop_',year,sep=''))]
   genelec[,paste('dr.marg.',year,sep='') := get(paste('dem_',year,sep=''))-get(paste('gop_',year,sep=''))]
   genelec[,paste('dr.pmarg.',year,sep='') := (get(paste('dem_',year,sep=''))-get(paste('gop_',year,sep='')))
                                                /get(paste('total_',year,sep=''))]
}

genelec[,pmarg.dif12 := dr.pmarg.2016-dr.pmarg.2012]
genelec[,pmarg.dif8 := dr.pmarg.2016-dr.pmarg.2008]
genelec[,marg.dif12 := dr.marg.2016-dr.marg.2012]
genelec[,marg.dif8 := dr.marg.2016-dr.marg.2008]
genelec[,ratio.dif12 := dr.ratio.2016-dr.ratio.2012]
genelec[,ratio.dif8 := dr.ratio.2016-dr.ratio.2008]

genelec = merge(cnty.lookup,genelec,by.x='fipsn',by.y='fips_code',all.x=TRUE)
genelec = select(genelec,statefipsn,cntyfipsn,total_2008:ncol(genelec))

path = paste(gdrivepath,'research/proj_010_trump/data/genelec.Rdata',sep='')
save(genelec,file=path)

# 
# # Graph it
# require(choroplethr)
# require(choroplethrMaps)
# plotdata = data.table(region=as.numeric(taaCnty$fips),value=taaCnty$nworkers)
# county_choropleth(plotdata)