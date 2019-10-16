# Import electoral votes total
library(tidyverse)
library(rvest)

z.url = 'https://www.archives.gov/federal-register/electoral-college/allocation.html'
elecvotes = read_html("") %>% # read the html page
    html_nodes("table") %>% # extract nodes which contain a table
    .[5] %>% # select the node which contains the relevant table
    html_table(trim = T) # extract the table


# Read HTML library    
URL <- "https://www.archives.gov/federal-register/electoral-college/allocation.html"
lst <- readHTMLTable(getURL(URL))

# Remove NULL elements in lst
lst <- Filter(Negate(is.null), lst)


z = htmlParse(z.url)

require(XML)
url = 'https://www.archives.gov/federal-register/electoral-college/allocation.html'
table = readHTMLTable(url,header = T,stringsAsFactors=F)

# Scale up results
varlist = 'cc.vote16'
z = postest.cces[, lapply(.SD, sum, na.rm = T), by = 'statename', .SDcols = varlist] # sum by state

# See who wins