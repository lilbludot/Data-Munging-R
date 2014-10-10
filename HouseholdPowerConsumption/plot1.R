
## Reading in the file
d = read.table("household_power_consumption.txt", sep=";",fill=FALSE, header = TRUE, strip.white=TRUE, colClasses = "character")

##Converting the Date column to Date format
d$Date <- as.Date(d$Date, format = "%d/%m/%Y")

##Creating a subset of the dataframe with the relevant dates
df <- subset(d, d$Date >= as.Date("2007-02-01" ) & d$Date <= as.Date("2007-02-02"))
head(df)
df$Global_active_power <- as.numeric(df$Global_active_power)
png("plot1.png", width=480, height=480)
hist(df$Global_active_power, xlab = "Global Active Power (kilowatts)", col ="red", main = "Global Active Power")
dev.off()

