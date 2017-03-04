library(quantmod)

# retrieve data for each company
google <- getSymbols("GOOG", src = "yahoo", auto.assign = FALSE)
facebook <- getSymbols("FB", src = "yahoo", auto.assign = FALSE)
amazon <- getSymbols("AMZN", src = "yahoo", auto.assign = FALSE)

# combine adjusted prices into a single xts object
companies <- cbind(google$GOOG.Adjusted, facebook$FB.Adjusted, amazon$AMZN.Adjusted)

# rename the variables, so that they displace nicely in the legend
names(companies) <- c("Google","Facebook","Amazon")

# draw a stock chart
dygraph(companies)

# customize the chart
dygraph(companies, ylab = "Adjusted close") %>%
  dyOptions(colors = brewer.pal(3, "Set1")) %>%
  dyRangeSelector() %>%
  dyAxis("x", drawGrid = FALSE)
