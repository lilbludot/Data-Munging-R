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
png("plot3.png", width=480, height=480)
plot(df$Timestamp, df$Sub_metering_1, type ="l", ylab ="Global Active Power", xlab =  NA)
lines(df$Timestamp, df$Sub_metering_2, type ="l", ylab ="Global Active Power", xlab =  "Time", col = "red")
lines(df$Timestamp, df$Sub_metering_3, type ="l", ylab ="Global Active Power", xlab =  "Time", col = "blue")
legend("topright", c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"),  lty = c(1, 1, 1), col = c("black", "red", "blue"))
dev.off()

