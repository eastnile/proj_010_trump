require(data.table)
require(ggplot2)
require(lubridate)
require(gridExtra)
require(choroplethr)
require(choroplethrMaps)
require(dplyr)

setwd("C:/Users/Zhaochen He/Google Drive/research/data/qwi")
load("qwi_allvars_naics2_allpersons_allcnty.Rda")


  
plotdata = data.table(region=as.numeric(hhidiff$fips),value=hhidiff$HhiDiff)

plotdata = data.table(region=as.numeric(hhidiff$fips),value=hhidiff$HhiMin)


county_choropleth(plotdata)


plotdata = data.table(region=as.numeric(hhidiff$fips),value=hhidiff$HhiMax)
county_choropleth(plotdata)
                    