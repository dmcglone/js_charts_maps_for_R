# load required packages
library(base)
library(stats)
library(readr)
library(dplyr)
library(htmlwidgets)
library(highcharter)
library(RColorBrewer)
library(leaflet)
library(rgdal)
library(dygraphs)
library(quantmod)
library(DT)

# load data
nations <- read_csv("nations.csv") 

# process data
gdp_regions <- nations %>%
  mutate(gdp = gdp_percap * population,
         gdp_tn = gdp/1000000000000) %>%
  group_by(region, year) %>%
  summarize(total_gdp_tn = sum(gdp_tn, na.rm = TRUE))

# basic symbol-and-line chart, default settings
highchart() %>%
  hc_add_series_df(data = gdp_regions,
                   type = "line",
                   x = year,
                   y = total_gdp_tn, 
                   group = region)

# define color palette
cols <- brewer.pal(7, "Set1")

highchart() %>%
  hc_add_series_df(data = gdp_regions,
                   type = "line",
                   x = year,
                   y = total_gdp_tn, 
                   group = region) %>%
  hc_colors(cols) %>%
  hc_xAxis(title = list(text="Year")) %>%
  hc_yAxis(title = list(text="GDP ($ trillion)")) %>%
  hc_plotOptions(series = list(marker = list(symbol = "circle")))

# save your code as an R object using the assignment operator
gdp_regions_chart <- highchart() %>%
  hc_add_series_df(data = gdp_regions,
                   type = "line",
                   x = year,
                   y = total_gdp_tn, 
                   group = region) %>%
  hc_colors(cols) %>%
  hc_xAxis(title = list(text="Year")) %>%
  hc_yAxis(title = list(text="GDP ($ trillion)")) %>%
  hc_plotOptions(series = list(marker = list(symbol = "circle")))

# use htmlwidgets package to export the chart as a web page, with supporting assets (JavaScript libraries and CSS files) saved in a folder called src.
saveWidget(gdp_regions_chart, "gdp_regions.html", selfcontained = FALSE, libdir = "src", background = "white")


