setwd("~/R/ExploratoryDataAnalysis/exdata-data-NEI_data")
library(dplyr)

#reading in the data
nei <- readRDS("summarySCC_PM25.rds")

#converting the data frame into a tbl_df object using the dplyr library
nei_df <- tbl_df(nei)

#removing the original data frame from the runtime environment
rm(nei)

#grouping the data by year and summing up the emission totals
sums <- nei_df %>%
           group_by(year) %>%
           summarise(total = sum(Emissions, na.rm = TRUE))

#adding a new column to the sums data frame that contains the totals in kilotonnes
final_df <- mutate(sums, PM25  = total/1000)

#Graphing the data using the base plotting system
with(final_df, plot(year, PM25, ylab = "Total Emissions (Kilotonnes)", xlab = "Year", pch = 16, col = "blue", main = " Yearly Total Fine Particulate Matter Emissions"))

#adding a linear regression line to the graph

model <- lm(PM25 ~ year, final_df)
abline(model)
