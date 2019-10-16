map.cnty = function(wrkdata,varname,ncolors) {
   require(choroplethr)
   require(stringr)
   cntyfipsstr = str_pad(wrkdata$cntyfipsn,3,pad='0')
   statefipsstr = str_pad(wrkdata$statefipsn,2,pad='0')
   fipsstrmap = paste(statefipsstr,cntyfipsstr,sep='')
   wrkdata = cbind(wrkdata,fipsstrmap)
   plotdata = data.table(region=as.numeric(wrkdata$fipsstrmap),
                         value=wrkdata[[deparse(substitute(varname))]])
   county_choropleth(plotdata,num_colors = ncolors)
}   

# This function generates per-capita values for a given wrkdata.
# NOTE: To increase speed, this function is designed so that you don't pass in
# the wrkdata, nor does it return a new wrkdata. Instead, it operates on the
# parent enviorment, executing the code to create per-capita variables in the
# same enviorment from which the function was called. This is why I am using
# substitute, eval, and parse.
# Synatax: gen.pc(work data <data.table>,
#                 names of variables <string array>,
#                 name of population variable (default:'pop') <string>)
# assign() might also work for this and be more elegant, I'm not sure.
gen.pc = function(wrkdata,varlist,popvar='pop',suffix='.pc'){
   for (var.i in varlist) {
      var = parse(text=var.i)
      popvar = parse(text=popvar)
      eval(substitute(
         wrkdata <- wrkdata[,paste(var.i,suffix,sep='') := eval(var)/eval(popvar)]),
         parent.frame())
   }
}
#    
# dt = data.table(a=c(1,2,3),b=c(2,3,4))
# t.f = function(data,column) {
#    return(data[[deparse(substitute(column))]])
# }
# rm(a)
# t.f(dt,a)
# 
# 
# dt[[deparse(a)]]
# 
# tester = quote(a)
# tester
# dt$tester
# dt$eval(tester)
# tester=substitute(a)
# tester
# class(tester)
# 
# f = function(x){
#    substitute(x)
#    x^2
# }
# 
# g = function(x){
#    x^2
# }
