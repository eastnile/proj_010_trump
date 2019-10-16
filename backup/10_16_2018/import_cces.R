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
t.in = as.data.table(read.spss(paste0(rawpath,'CCES 2016 Data Modified.sav'),to.data.frame=T))
setnames(t.in,names(t.in),paste('cc',names(t.in),sep='.'))
cces = t.in

loadmain()
ccesplus = merge(x = cces, y = main, by.x = 'cc.countyfips', by.y = 'fipsn.x', all.x=T)
save(cces,cces.meta,ccesplus,file=paste(gdrivepath,'research/proj_010_trump/data/cces.Rdata',sep=''))
fwrite(ccesplus,file=paste0(datpath,'ccesplus.csv'))
fwrite(cces.meta[,1:3],file=paste0(datpath,'ccesmeta.csv'))
