# Import electoral votes total
library(tidyverse)
library(rvest)

z.url = 'https://www.archives.gov/federal-register/electoral-college/allocation.html'
elecvotes = read_html(z.url) %>% # read the html page
    html_nodes("table") %>% # extract nodes which contain a table
    .[5] %>% # select the node which contains the relevant table
    html_table(trim = T) # extract the table
elecvotes = elecvotes[[1]]

names(elecvotes) = c('statename','evotes')
save(elecvotes, file = 'elecvotes.Rdata')