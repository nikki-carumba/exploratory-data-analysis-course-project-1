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
png("plot4.png", width=480, height=480)
par(mfrow = c(2, 2)) 

#plot data
plot(data$datetime, data$Global_active_power, type="l", xlab="", ylab="Global Active Power", cex=0.2)
plot(data$datetime, voltage, type="l", xlab="datetime", ylab="Voltage")
plot(data$datetime, data$Sub_metering_1, type="l", ylab="Energy Submetering", xlab="")
lines(data$datetime, data$Sub_metering_2, type="l", col="red")
lines(data$datetime, data$Sub_metering_3, type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=, lwd=2.5, col=c("black", "red", "blue"), bty="o")

plot(data$datetime, data$Global_active_power, type="l", xlab="datetime", ylab="Global_reactive_power")

dev.off()
