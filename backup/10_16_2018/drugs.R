require(data.table)

path='C:/Users/Zhaochen He/Google Drive/research/proj_010_trump/data/raw/Nat2016PublicUS.c20170517.r20170913.txt'

fread(path,fill=T)

df <- read.csv(file=path,nrows=1,header=F)


df <- read.csv(file=path,nrows=1,header=F,sep=' ')
