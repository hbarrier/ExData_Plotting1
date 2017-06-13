## Coursera Data Science 
## Peer graded assignment 
## Author: Hermine Barriere

## ****************************************************************************

# Load the dplyr package - due to file size, this provides efficient reading of the data
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

## PLOT 2
# concatenate Date & Time in a field to be used on the X axis
ppower$DateTime <- ymd_hms(paste(ppower$Date, ppower$Time, sep = " ")) 
# reinitiating the mfrow parameter in case plot 4 was run previously
par(mfrow=c(1,1))
# display plot on screen first
plot(ppower$DateTime, ppower$Global_active_power, type = "l", xlab="", ylab="Global Active Power (kilowatts)")

# save the plot in a png
png(filename = "plot2.png", width = 480, height = 480, units = "px")
plot(ppower$DateTime, ppower$Global_active_power, type = "l", xlab="", ylab="Global Active Power (kilowatts)")
dev.off()


