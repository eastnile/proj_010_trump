setproj(10)
require(foreign)
require(XML)

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
   cces[[varname]] = plyr::mapvalues(t.in,from=cat.in,to=cat.out) # remap values
}
# Create dummies as needed
# cc.employ
cces[,cc.emp.nilf := 0]
cces[cc.employ==98|cc.employ==99|cc.employ==5|cc.employ==6|cc.employ==7|cc.employ==8|cc.employ==9,cc.emp.nilf := 1] # Code NILF
cces[, cc.emp.ft := 0] # Employed full time
cces[cc.employ==1,cc.emp.ft := 1]
cces[, cc.emp.pt := 0] # Employed part time
cces[cc.employ==2,cc.emp.pt := 1]
cces[, cc.emp.nojob := 0] # Unemployed
cces[cc.employ==3 | cc.employ == 4, cc.emp.nojob := 1]
cces[cc.emp.nilf == 1, c('cc.emp.ft','cc.emp.pt','cc.emp.nojob') :=  0]

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
cces[cc.marstat == 5, cc.marstat.single := 1]

# Create New Variables
cces[, cc.fortunesum := (cc.CC16_305_3 + cc.CC16_305_1 + cc.CC16_305_7 + cc.CC16_305_11 + cc.CC16_305_4 + cc.CC16_305_6
    - cc.CC16_305_10 - cc.CC16_305_9 - cc.CC16_305_5 - cc.CC16_305_2)/10] # sum of fortunes
cces[, cc.immviewsum := (cc.CC16_331_1 + cc.CC16_331_7 + cc.CC16_331_3 + cc.CC16_331_2)/4] # immigration views
cces[, cc.raceviewsum := (cc.CC16_422c + cc.CC16_422d + cc.CC16_422e + cc.CC16_422f) / 4] # race views

# Vote vars
for (var in c('cc.vote16.gop', 'cc.vote16.dem', 'cc.vote16.oth')) {
    cces[, paste0(var) := 0]
    cces[cc.GEVote > 5 | is.na(cc.GEVote), paste0(var) := NA]
    }
cces[cc.GEVote == 1, cc.vote16.gop := 1]
cces[cc.GEVote == 2, cc.vote16.dem := 1]
cces[cc.GEVote >= 3 & cc.GEVote <= 5, cc.vote16.oth := 1]

for (var in c('cc.vote12.gop', 'cc.vote12.dem', 'cc.vote12.oth')) {
    cces[, paste0(var) := 0]
    cces[cc.CC16_326 > 4 | is.na(cc.CC16_326), paste0(var) := NA]
}
cces[cc.CC16_326 == 2, cc.vote12.gop := 1]
cces[cc.CC16_326 == 1, cc.vote12.dem := 1]
cces[cc.CC16_326 >= 3 & cc.CC16_364c <= 4, cc.vote12.oth := 1]
#View(select(cces, cc.CC16_364c, contains('vote16')))

# Primaries
# Turnout
cces[, cc.vote16.pri.turnout := 0]
cces[, cc.vote16.pri.turnout := NA]
cces[cc.CC16_327==1, cc.vote16.pri.turnout := 1]
cces[cc.CC16_327 == 2, cc.vote16.pri.turnout := 0]
cces[cc.PrimaryVote >= 1 & cc.PrimaryVote < 9, cc.vote16.pri.turnout := 1]

cces[, cc.vote16.pri := 0]
cces[, cc.vote16.pri := NA]
cces[cc.PrimaryVote == 1, cc.vote16.pri := 1]
cces[cc.PrimaryVote == 2, cc.vote16.pri := 2]
cces[cc.PrimaryVote == 3, cc.vote16.pri := 3]
cces[cc.PrimaryVote == 4, cc.vote16.pri := 4]
cces[cc.PrimaryVote == 5, cc.vote16.pri := 5]
cces[cc.PrimaryVote == 6, cc.vote16.pri := 6]
cces[cc.PrimaryVote == 7, cc.vote16.pri := 7]
cces[cc.PrimaryVote == 8, cc.vote16.pri := 8]
cces[cc.PrimaryVote == 9, cc.vote16.pri := 9]

factor(cces$cc.vote16.pri, labels = c('Hillary Clinton','Bernie Sanders','Another Democrat','Donald Trump','Ted Cruz','John Kasich','Marco Rubio','Another Republican', 'Not a Democrat or Republican'))

cces$cc.vote16.pri.trump = NA
cces$cc.vote16.pri.trump = ifelse(cces$cc.vote16.pri == 4, 1, 0)
cces$cc.vote16.pri.cruz = NA
cces$cc.vote16.pri.cruz = ifelse(cces$cc.vote16.pri == 5, 1, 0)
cces$cc.vote16.pri.clinton = NA
cces$cc.vote16.pri.clinton = ifelse(cces$cc.vote16.pri == 1, 1, 0)
cces$cc.vote16.pri.sanders = NA
cces$cc.vote16.pri.sanders = ifelse(cces$cc.vote16.pri == 2, 1, 0)


# Turnout
cces[, cc.vote16.turnout := 0]
cces[cc.CC16_401 >= 8, cc.vote16.turnout := NA]
cces[cc.CC16_401 == 5, cc.vote16.turnout := 1]
# 2016 GE Vote, as.factor, for mlogit
cces[, cc.vote16 := 0]
cces[is.na(cc.GEVote), cc.vote16 := NA]
cces[cc.GEVote == 7 | cc.GEVote >= 9, cc.vote16 := NA]
cces[cc.GEVote == 1, cc.vote16 := 1]
cces[cc.GEVote == 2, cc.vote16 := 2]
cces[cc.GEVote == 3, cc.vote16 := 3]
cces[cc.GEVote == 4, cc.vote16 := 4]
cces[cc.GEVote == 8, cc.vote16 := 5]
cces[cc.GEVote == 5, cc.vote16 := 6]
cces[cc.GEVote == 6 | cc.vote16.turnout == 0, cc.vote16 := 0]
factor(cces$cc.vote16, labels = c('Did not vote', 'Donald Trump', 'Hillary Clinton', 'Gary Johnson', 'Jill Stein', 'Evan McMullin', 'Other'))
#View(select(cces, cc.GEVote, cc.vote16.turnout, cc.vote16))
# 2012 GE Vote, as.factor, for mlogit
cces[, cc.vote12 := 0]
cces[is.na(cc.CC16_326) | cc.CC16_326 >= 5, cc.vote12 := NA]
cces[cc.CC16_326 == 1, cc.vote12 := 2]
cces[cc.CC16_326 == 2, cc.vote12 := 1]
cces[cc.CC16_326 == 3, cc.vote12 := 3]
cces[cc.CC16_326 == 4, cc.vote12 := 0]
cces$cc.vote12=factor(cces$cc.vote12, labels = c('Did not vote', 'Barrack Obama', 'Mitt Romney', 'Other'))

# Other Variables
# Interactions

cces[, cc.i.white.educhs := cc.WhiteDum * cc.maxeduc.hs]

# Save
save(cces,cces.meta,file=paste(gdrivepath,'research/proj_010_trump/data/cces.Rdata',sep=''))


# fwrite(ccesplus.fscaled,file=paste0(datpath,'ccesplus_fscaled.csv'))
# fwrite(ccesplus,file=paste0(datpath,'ccesplus.csv'))

# fwrite(cces.meta[,1:3],file=paste0(datpath,'ccesmeta.csv'))



