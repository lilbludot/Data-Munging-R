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

png("plot4.png", width=480, height=480)
par(mfrow=c(2,2))
hist(df$Global_active_power, xlab = "Global Active Power (kilowatts)", col ="red", main = "Global Active Power")
plot(df$Timestamp, df$Voltage, type = "l", ylab ="Voltage", xlab = "datetime")
plot(df$Timestamp, df$Sub_metering_1, type ="l", ylab ="Global Active Power", xlab =  NA)
lines(df$Timestamp, df$Sub_metering_2, type ="l", ylab ="Global Active Power", xlab =  "Time", col = "red")
lines(df$Timestamp, df$Sub_metering_3, type ="l", ylab ="Global Active Power", xlab =  "Time", col = "blue")
legend("topright", c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"),  lty = c(1, 1, 1), cex = 0.8, col = c("black", "red", "blue"), bty = "n")
plot(df$Timestamp, df$Global_reactive_power, type="l", ylab = "Global_reactive_power", xlab= "datetime")
dev.off()

