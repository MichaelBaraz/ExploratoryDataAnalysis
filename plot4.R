# Program name:   plot4.R
# Author:         Michael Baraz
# Purpose:        Create four panel combination plot per assignment


#Read file into a dataframe and set date and time columns
power <- read.table("household_power_consumption.txt",
                   header=TRUE,
                   sep=";",
                   colClasses=c("character", "character", rep("numeric",7)),
                   na="?")

# convert date and time variables to Date/Time class
power$Time <- strptime(paste(power$Date, power$Time), "%d/%m/%Y %H:%M:%S")
power$Date <- as.Date(power$Date, "%d/%m/%Y")
# filter dates 2007-02-01 and 2007-02-02
dates <- as.Date(c("2007-02-01", "2007-02-02"), "%Y-%m-%d")
# apply filter
power <- subset(power, Date %in% dates)


#create PNG file
png("plot4.png", height=480, width=480)


#setup for format for the four panel series
par(mfrow=c(2,2))


#plot the histogram graph, #1
plot(power$Time, 
     power$Global_active_power,
     type="l",
     xlab="",
     ylab="Global Active Power")


#plot the time series graph, #2
plot(power$Time, 
     power$Voltage, 
     type="l",
     xlab="datetime", 
     ylab="Voltage"
)


#plot the energy sub metering comparison graph #3
plot(power$Time, power$Sub_metering_1, type="l", col="black", xlab="", ylab="Energy sub metering")
lines(power$Time, power$Sub_metering_2, col="red")
lines(power$Time, power$Sub_metering_3, col="blue")
legend("topright",
       col=c("black", "red", "blue"),
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty=1, 
       lwd=2
)


#plot the time series graph for global reactive power, #4
plot(power$Time, 
     power$Global_reactive_power, 
     type="n",
     xlab="datetime", 
     ylab="Global_reactive_power"
)
lines(power$Time, power$Global_reactive_power)


#close device
dev.off()

#end plot4
