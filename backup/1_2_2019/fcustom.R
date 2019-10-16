# This function creates a cloropleth map for county level data.
map.cnty = function(wrkdata,varname,ncolors) {
   require(choroplethr)
   require(stringr)
   cntyfipsstr = str_pad(wrkdata$cntyfipsn,3,pad='0')
   statefipsstr = str_pad(wrkdata$statefipsn,2,pad='0')
   fipsstrmap = paste(statefipsstr,cntyfipsstr,sep='')
   wrkdata = cbind(wrkdata,fipsstrmap)
   plotdata = data.table(region=as.numeric(wrkdata$fipsstrmap),
                         value=wrkdata[[deparse(substitute(varname))]])
   county_choropleth(plotdata,num_colors = ncolors,title=deparse(substitute(varname)))
}   

# This function generates per-capita values for a given wrkdata.
# NOTE: To increase usability, the function doesn't return anything; it just modifies the data
# frame that it's called on. Also, I'm using substitute, eval, and parse largly as an experiment.
# You could instead call data.table and use 'with = F'. assign() might also work.
# Synatax: gen.pc(work data <data.table>,
#                 names of variables <string array>,
#                 name of population variable (default:'pop') <string>)

gen.pc = function(wrkdata,varlist,popvar='pop',suffix='.pc'){
   for (var.i in varlist) {
      var = parse(text=var.i)
      popvar = parse(text=popvar)
      eval(substitute(
         wrkdata <- wrkdata[,paste(var.i,suffix,sep='') := eval(var)/eval(popvar)]),
         parent.frame())
   }
}

# This function creates a heatmap for a correlation matrix. Note: there's also many pkgs to
# do this, such as ggcorrplot
heatmap.cor = function(df) {
require('colorspace')
require('gplots')
t.cor = cor(df,use='pairwise')
t.cor.round = round(t.cor,digits=2)
cols = diverge_hsv(100,alpha=1)
heatmap.2(t.cor, Rowv = F, Colv = F, dendrogram='none', key = F, symm = T,trace='none',
          col = cols,
          lwid = c(.01,.99),lhei = c(.01,.99),margins = c(10,10),
          cellnote = t.cor.round, notecol = 'black')
}

# This function plots employment across industries over time using QWI data.
plot.allind = function(wrkdata,varname,st1,cnty1){
   fwrkdata = wrkdata[statefipsn == st1 & cntyfipsn == cnty1]
   fwrkdata$industry = as.factor(fwrkdata$industry)
   ggplot(data = fwrkdata, aes_string(x='dt',y=varname)) + 
      geom_line(aes(color=industry), size=1) + 
      geom_point(aes(shape=industry)) +
      scale_shape_manual(values=1:nlevels(fwrkdata$industry)) +
      scale_x_date(date_breaks ="1 year") +
      theme(axis.text.x=element_text(angle=60, hjust=1))
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
