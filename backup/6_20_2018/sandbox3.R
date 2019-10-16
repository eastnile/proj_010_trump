eras = function(ts) {
   require(data.table)
   d2 = diff(diff(ts) > 0)
   xmax = which(d2==-1) + 1
   xmin = which(d2== 1) + 1
   xcrit = sort(c(1,xmax,xmin,length(ts)))
   eras = data.table(dtbeg = numeric(), dtend=numeric(), dx=numeric(),dy=numeric())
   for (i in 1:(length(xcrit)-1)) {
      dtbeg = xcrit[i]
      dtend = xcrit[i+1]
      dx = xcrit[i+1]-xcrit[i]
      dy = ts[xcrit[i+1]]-ts[xcrit[i]]
      row = data.table(dtbeg,dtend,dx,dy)
      eras = rbind(eras,row)
   }
   return(eras)
}



# Try to pull a specific TS


wrkdata = wrkdata[,c('state','county','industry') := lapply(.SD,factor), .SDcols = c('state','county','industry')]
indtsguide = unique(wrkdata[,.(state,county,industry)])
indtsguide = indtsguide[order(state,county,industry)]
indtsguide[,id:=.I]


setkey(wrkdata,state,county,industry)
indts = list()

# for (i in 1:100) {
for (i in 1:nrow(indtsguide)) {
   #print(a$state[i])
   #print(a$county[i])
   #print
   if (i %% 1000 == 0) {
      print(i)
   }
   #print(b[state==a$state[i] & county==a$county[i] & industry==a$industry[i]]$Emp)
   indts[[i]] = wrkdata[.(indtsguide$state[i],indtsguide$county[i],indtsguide$industry[i])]$EmpTotalSm
   #tester[[i]]=b[state==a$state[i] & county==a$county[i] & industry==a$industry[i]]$Emp
   #tester[i]=b[state==a$state[i] & county==a$county[i] & industry==a$industry[i]]$Emp
}

require(parallel)
ncores = detectCores()-1
local = makeCluster(ncores)
eraout=parLapply(cl=local,indts,eras)
#           
stopCluster(local)

indtsguide$state[2]

st1="17"
cnty1="095"

z=indtsguide[state=="st1"&county=="cnty1"]

z=indtsguide[state=="17"&county=="095"]

# Old Code

# x1 = c(3,2,9,9,2,1,1,5,5,1)
# x2 = c(3,2,9,9,2,1,1,5,5,1)
# x3 = c(3,2,9,9,2,1,1,5,5,1)
# x4 = c(3,2,9,9,2,1,1,5,5,1)
# x5 = c(3,2,9,9,2,1,1,5,5,1)
# x6 = c(3,2,9,9,2,1,1,5,5,1)
# x7 = c(3,2,9,9,2,1,1,5,5,1)
# x8 = c(3,2,9,9,2,1,1,5,5,1)
# x9 = c(3,2,9,9,2,1,1,5,5,1)
# x10 = c(3,2,9,9,2,1,1,5,5,1)
# x11 = c(3,2,9,9,2,1,1,5,5,1)
# x12 = c(3,2,9,9,2,1,1,5,5,1)
# 
# xn = list(x1,x2,x3,x4,x5,x6,x7,x8,x9,x10,x11,x12)
# 
# a=lapply(xn,eras)