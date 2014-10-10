#setwd("~/R/exdata-data-household_power_consumption")
## Reading in the file
data = read.table("household_power_consumption.txt", sep=";",fill=FALSE, header = TRUE, strip.white=TRUE, colClasses = "character")
data$Timestamp = strptime(paste(data$Date, data$Time), format = "%d/%m/%Y %H:%M:%S")
head(data)
##Converting the Date column to Date format
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
##Creating a subset of the dataframe with the relevant dates
df <- subset(data, data$Date >= as.Date("2007-02-01" ) & data$Date <= as.Date("2007-02-02"))
head(df)
df$Global_active_power <- as.numeric(df$Global_active_power)
png("plot2.png", width=480, height=480)
plot(df$Timestamp, df$Global_active_power, type ="l", ylab ="Global Active Power", xlab =  NA)
dev.off()

