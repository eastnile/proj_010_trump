require(foreign)
require(XML)
require(dplyr)
require(plyr)

# Import Metadata
p.meta = paste0(rawpath,'CCES16_Common_OUTPUT_Feb2018_VV-ddi.xml')
t.meta = xmlToList(xmlTreeParse(p.meta))
cces.meta = data.frame(vname=character(),descr=character(),cat=character(),catlist=I(list()),stringsAsFactors = F)
for (i in 1:length(t.meta$dataDscr)) {
   #print(t.meta$dataDscr[[i]])\
   cces.meta[i,1] = t.meta$dataDscr[[i]]$.attrs['name']
   cces.meta[i,2] = t.meta$dataDscr[[i]]$labl$text
   cat = list()
   k = 1
   for (j in 1:length(t.meta$dataDscr[[i]])) {
      t = t.meta$dataDscr[[i]]
      if (class(t[[j]]) == 'list') {
         #print('not a list')
         if (is.null(t[[j]]$catValu)) {
            #print('not a cat')
         } else {
            #print('found one')
            cat$num[[k]] = t[[j]]$catValu
            cat$descr[[k]] = t[[j]]$labl$text
            k = k + 1
         }
      }
   }
   cces.meta$catlist[[i]]=cat
   cces.meta$cat[[i]] = paste(sort(paste(cat$num,'-',cat$descr)),collapse=', ')
}

# Prep data

# Read in John's modified CCES data
t.in = as.data.table(read.spss(paste0(rawpath,'CCES 2016 Data Modified.sav'),to.data.frame=T))
cces = t.in
# Read in raw CCES data
load(paste0(rawpath,'CCES16_Common_OUTPUT_Feb2018_VV.RData'))
ccesorig = x

# Compare those datasets
namesjohn = as.data.table(names(cces))
namesjohn = cbind(namesjohn,rep('john',nrow(namesjohn)))
namesorig = as.data.table(names(ccesorig))
namesorig = cbind(namesorig,rep('orig',nrow(namesorig)))
namecompare = merge(namesjohn,namesorig,by='V1',all=T)

# Read from gsheets info to remap variables
gsKey = '1F9WgoFMqd0yHVtc7ux1mAtntdOhAx6igw9ylo-PGxGs'
gstarget = gs_key(gsKey)
gsdat = data.table(gs_read(gs_key(gsKey),ws='cces codebook'))
recodelist = gsdat[!is.na(recodein)&recodein!='makedum',.(varname.raw,categories,recodein,recodeout)]
makedumlist = gsdat[recodein=='makedum']

# Overwrite John's variables with originals, so I can use my own recode system
for (varname in recodelist$varname.raw) {
   cces[[varname]]=ccesorig[[varname]]
}
setnames(cces,names(cces),paste('cc',names(cces),sep='.')) # Add .cc to variable name

# Recode variables
for (i in 1:nrow(recodelist)) { # for (i in 1:1) {
   print(recodelist$varname.raw[i])
   varname = recodelist$varname.raw[i]
   cat.in = as.integer(unlist(strsplit(recodelist$recodein[i],split=',')))    # Create dictionary
   cat.out = unlist(strsplit(recodelist$recodeout[i],split=','))
   cat.out[cat.out=='na'] = NA
   cat.out=as.integer(cat.out)
   t.in = cces[[varname]] # pull variable
   cces[[varname]] = mapvalues(t.in,from=cat.in,to=cat.out) # remap values
}
# Create dummies as needed
# cc.employ

cces[,cc.emp.nilf := 0]
cces[cc.employ==98|cc.employ==99|cc.employ==5|cc.employ==6|cc.employ==7|cc.employ==8|cc.employ==9,cc.emp.nilf := 1]
cces[,cc.emp.ft := 0]
cces[cc.employ==1,cc.emp.ft := 1]
cces[,cc.emp.pt := 0]
cces[cc.employ==2,cc.emp.pt := 1]
cces[,cc.emp.nojob := 0]
cces[cc.employ==3 | cc.employ == 4,cc.emp.nojob := 1]
cces[cc.emp.nilf == 1,c('cc.emp.ft','cc.emp.pt','cc.emp.nojob') :=  NA]

# cc.imstat
cces[,cc.isimmigrant := 0]
cces[cc.immstat<=3,cc.isimmigrant := 1]
# cc.educ
cces[,cc.maxeduc.nohs := 0]
cces[cc.educ==1,cc.maxeduc.nohs := 1]
cces[,cc.maxeduc.hs := 0]
cces[cc.educ==2,cc.maxeduc.hs := 1]
cces[,cc.maxeduc.2yr := 0]
cces[cc.educ==4,cc.maxeduc.2yr := 1]
cces[,cc.maxeduc.4yr := 0]
cces[cc.educ==5,cc.maxeduc.4yr := 1]
cces[,cc.maxeduc.adv := 0]
cces[cc.educ==6,cc.maxeduc.adv := 1]
#cc.marstat
cces[,cc.marstat.married := 0]
cces[cc.marstat==1,cc.married := 1]
cces[,cc.marstat.sepdiv := 0]
cces[cc.marstat==2|cc.marstat==3,cc.marstat.sepdiv := 1]
cces[,cc.marstat.widow := 0]
cces[cc.marstat==4,cc.marstat.widow := 1]
cces[,cc.marstat.single := 0]
cces[cc.marstat==5,cc.marstat.single := 1]

# Save
save(cces,cces.meta,file=paste(gdrivepath,'research/proj_010_trump/data/cces.Rdata',sep=''))
# fwrite(ccesplus,file=paste0(datpath,'ccesplus.csv'))
# fwrite(cces.meta[,1:3],file=paste0(datpath,'ccesmeta.csv'))



