library(plotly)

ltr = LETTERS[seq(from = 1, to = 26)]

wght = runif(length(ltr))
wght = wght / sum(wght)
wght = round(wght, digits = 2)

alloc = as.data.frame(cbind(ltr, wght))
alloc$wght = as.numeric(as.character(alloc$wght))


p <- plot_ly(alloc, labels = ~ltr, values = ~wght, type = 'pie', textposition = 'outside', textinfo = 'label+percent') %>%
    layout(title = 'Letters',
         xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
         yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))