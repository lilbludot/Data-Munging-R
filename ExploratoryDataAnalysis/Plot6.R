library(dplyr)
library(ggplot2)
nei <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
nei_df <- tbl_df(nei)
scc_df <-tbl_df(SCC)
#rm(nei)
#rm(SCC)
#Finding all "vehicles" entries in column EI.Sector
V <- unique(grep("vehicles", scc_df$EI.Sector, ignore.case=TRUE, value =TRUE))

#creating a new tbl_df that contains only the rows where EI.Sector 
#contains the word "vehicles"
filtered_scc <- filter(scc_df, EI.Sector %in% V)

#joining filtered_scc and nei_df on SCC
combined_df <- inner_join(nei_df, filtered_scc, by = "SCC")

#Finding the yearly total motor vehicle emissions for Baltimore, Maryland
sumsB <- combined_df %>%
  filter(fips == "24510") %>%
  group_by( year) %>%
  summarise(total = sum(Emissions, na.rm = TRUE)) %>%
  mutate(PM25 = total/1000, location="Baltimore")
  

#Finding the yearly total motor vehicle emissions for Los Angeles, California
sumsLA<- combined_df %>%
  filter(fips == "06037") %>%
  group_by( year) %>%
  summarise(total = sum(Emissions, na.rm = TRUE)) %>%
  mutate(PM25 = total/1000, location = "Los Angeles")

compare_df <- rbind(sumsB, sumsLA)


#Graphing the data using ggplot2
ggplot(compare_df, aes(x=factor(year), y=PM25, fill=location))+
  geom_bar(position="dodge", stat="identity")+
  labs(title="Yearly Vehicle Emssion Comparison by Location", y = "Total Emissions (kiloTonnes)", x = "Year")

