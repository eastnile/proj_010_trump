#Read in data
codepath = paste(gdrivepath,"research/proj_010_trump/",sep="")

files=data.table(filename=character(),descr=character(),path=character())

files= rbind(files,
   data.table(filename='import_taa',
              descr='import TAA dataset',
              path=paste(codepath,'import_taa.R',sep="")
              )
   )

files= rbind(files,
             data.table(filename='import_politics',
                        descr='import primaries data',
                        path=paste(codepath,'import_politics.R',sep="")
             )
)

for (i in c(1,2)){
   source(files$path[i])
}
   
   
