library(dplyr)
nei <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
nei_df <- tbl_df(nei)
scc_df <-tbl_df(SCC)
#rm(nei)
#rm(SCC)
V <- unique(grep("vehicles", scc_df$EI.Sector, ignore.case=TRUE, value =TRUE))
filtered_scc <- filter(scc_df, EI.Sector %in% V)
combined_df <- inner_join(nei_df, filtered_scc, by = "SCC")
sums <- combined_df %>%
  filter(fips == "24510") %>%
  group_by( year) %>%
  summarise(total = sum(Emissions, na.rm = TRUE)) %>%
  mutate(PM25 = total/1000)


#Graphing the data using the base plotting system
with(sums, plot(year, PM25, ylab = "Total Emissions (Kilotonnes)", xlab = "Year", pch = 16, col = "blue"))
title(main = list("Yearly Emissions from Motor Vehicle Sources in Baltimore, Maryland", col = "blue", font = 3))
                  
#adding a linear regression line to the graph

model <- lm(PM25 ~ year, sums)
abline(model)
