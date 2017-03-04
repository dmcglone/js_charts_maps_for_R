library(dt)

# filter data for 2014 only
longevity <- nations %>%
  filter(year == 2014 & !is.na(life_expect)) %>%
  select(country, life_expect, income, region) %>%
  arrange(desc(life_expect))

# rename the variables for display in the table
names(longevity) <- c("Country","Income group","Region","Life expectancy")

datatable(longevity)

datatable(longevity,  
          rownames = FALSE) %>% 
  formatStyle("Life expectancy",
              color = "red",
              fontWeight = "bold")