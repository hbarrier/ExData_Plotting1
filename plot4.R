## Coursera Data Science 
## Peer graded assignment 
## Author: Hermine Barriere

## ****************************************************************************

# Load the splyr package - due to file size, this provides efficient reading of the data
# and displays progress while reading the file
library(dplyr)
# Load lubridate to set variable Date in date format- much quicker than strptime
library(lubridate)

# Changing system locals to have axis in English instead of French
Sys.setlocale("LC_ALL", "English")

# Download the zip file and read it in a dataset called "power" 
temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", temp)
power <- read_delim(unzip(temp, files = "household_power_consumption.txt"), na="?", delim = ";")
unlink(temp)

# Subset the data to keep only data from the dates 2007-02-01 and 2007-02-02
power$Date <- dmy(power$Date)
# solution below was chosen as it is much quicker than using subsetting such as: 
# ppower <- filter(power, Date >="2007-02-01" & Date <= "2007-02-02")
ppower <- power %>% filter(year(Date)==2007) %>% filter(month(Date)==2) %>% filter(day(Date) %in% c(1,2))
# remove initial dataset to free memory
rm("power")

## PLOT 4
# concatenate Date & Time in a field to be used on the X axis
ppower$DateTime <- ymd_hms(paste(ppower$Date, ppower$Time, sep = " ")) 

# display 4 plots by row, 2rows / 2 cols
par(mfrow=c(2,2))
# display plot on screen first
# First plot
plot(ppower$DateTime, ppower$Global_active_power, type = "l", xlab="", ylab="Global Active Power")
# Second plot
plot(ppower$DateTime, ppower$Voltage, type = "l",  xlab="datetime", ylab="Voltage")
# Third plot
plot(ppower$DateTime, ppower$Sub_metering_1, type = "l", col = "black", xlab = "", ylab = "Energy sub metering")
lines(ppower$DateTime, ppower$Sub_metering_2, col = "red")
lines(ppower$DateTime, ppower$Sub_metering_3, col = "blue")
legend("topright", lty = 1, col=c("black", "red", "blue"), legend =c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), bty="n")
# Fourth plot
plot(ppower$DateTime, ppower$Global_reactive_power, type = "l", xlab="datetime", ylab="Global_reactive_power")

# save the plot in a png
png(filename = "plot4.png", width = 480, height = 480, units = "px")
par(mfrow=c(2,2))
# First plot
plot(ppower$DateTime, ppower$Global_active_power, type = "l", xlab="", ylab="Global Active Power")
# Second plot
plot(ppower$DateTime, ppower$Voltage, type = "l",  xlab="datetime", ylab="Voltage")
# Third plot
plot(ppower$DateTime, ppower$Sub_metering_1, type = "l", col = "black", xlab = "", ylab = "Energy sub metering")
lines(ppower$DateTime, ppower$Sub_metering_2, col = "red")
lines(ppower$DateTime, ppower$Sub_metering_3, col = "blue")
legend("topright", lty = 1, col=c("black", "red", "blue"), legend =c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), bty="n")
# Fourth plot
plot(ppower$DateTime, ppower$Global_reactive_power, type = "l", xlab="datetime", ylab="Global_reactive_power")
dev.off()

