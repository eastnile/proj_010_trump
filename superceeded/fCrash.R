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

map.allind = function(wrkdata,varname) {
   require(choroplethr)
   plotdata = data.table(region=as.numeric(wrkdata$fipsstr),value=wrkdata[[varname]])
   county_choropleth(plotdata)
}   
   

# findcrash = function(wrkdata,varname){
#    for(vname in varname){
#       #print(vname)
#       fwrkdata = wrkdata[, rank := rank(-get(vname), 
#                                         na.last=TRUE, ties.method='first')
#                          , by = .(dt,state,county)]
#       fwrkdata = fwrkdata[, max := max(get(vname), na.rm=TRUE)
#                           , by = .(industry,state,county)]
#       fwrkdata = fwrkdata[, min := min(get(vname), na.rm=TRUE)
#                           , by = .(industry,state,county)]
#       
#       # ids = wrkdata[,1:4]
#       # rank = wrkdata[, rank(-get(vname), na.last=TRUE,ties.method='first')
#       #         , by = .(dt,state,county)]$V1
#       # max = wrkdata[, max(get(vname), na.rm=TRUE)
#       #         , by = .(industry,state,county)]
#       # min = wrkdata[, min(get(vname), na.rm=TRUE)
#       #         , by = .(industry,state,county)]
#       
#       return(fwrkdata)
#       #print(vname)
#    }
# }