setwd("~/R/ExploratoryDataAnalysis/exdata-data-NEI_data")
library(dplyr)
library(ggplot2)

#reading in the data
nei <- readRDS("summarySCC_PM25.rds")

#converting the data frame into a tbl_df object using the dplyr library
nei_df <- tbl_df(nei)

#removing the original data frame from the runtime environment
rm(nei)

#grouping the data by year and summing up the emission totals
sums <- nei_df %>%
           filter(fips == 24510) %>%
           group_by(type, year) %>%
           summarise(total = sum(Emissions, na.rm = TRUE)) %>%
           mutate(PM25 = total/1000)

#adding a new column to the sums data frame that contains the totals in kilotonnes


#Graphing the data using ggplot

ggplot(sums, aes(year, PM25)) + geom_point(aes(color=type, size =2))+facet_grid(type ~ .) + 
  geom_smooth(method = "lm", se = FALSE)+
  labs(title="Emissions by Source in Baltimore, Maryland", y = "Total Emissions (kiloTonnes)", x = "Year")
