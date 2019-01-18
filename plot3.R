#read data
power <- read.table("household_power_consumption.txt",skip=1,sep=";", na.strings="?")
#set column names
names(power) <- c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")

#Convert the Date variables to Date class
power$Date <- as.Date(power$Date, format = "%d/%m/%Y")

#data from the dates 1/2/2007 and 1/2/2007
data <- subset(power, subset = (Date >= "2007-02-01" & Date <= "2007-02-02"))

#Convert to date and time
data$datetime <- strptime(paste(data$Date, data$Time), "%Y-%m-%d %H:%M:%S")
data$datetime <- as.POSIXct(data$datetime)

# Save to file
png("plot3.png", width=480, height=480)

plot(data$datetime,data$Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab = "")
lines(data$datetime, data$Sub_metering_2 , col = "Red")
lines(data$datetime, data$Sub_metering_3 , col = "Blue")
legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

dev.off()
