## This file reads the measurement of electric power consumption in a 
## household from the given file and creates a plot of the 
## Energy Submetering value for the two days - 01-Feb-2007 and 02-Feb-2007

## Read the file into the object power_cons

power_cons <- read.delim("household_power_consumption.txt", sep=";", 
                         header = TRUE, colClasses ="character")

## The dates for which the values are to be plotted are added to a vector
Required_dates <- as.Date(c("2007-02-01", "2007-02-02"))

## Subsetting the object power_cons to get the values for 
## 1st Feb 2007 and 2nd Feb 2007
power_cons_date <- subset (power_cons, as.Date(power_cons$Date, "%d/%m/%Y")
                           %in% Required_dates)

## Create and open the png file 
png ("plot3.png", width = 480, height = 480, units = "px")

## Making the timestamp and adding it as a column to power_cons_date
power_time_stamp <- as.POSIXct(paste(power_cons_date$Date, power_cons_date$Time), format="%d/%m/%Y %H:%M:%S")
power_cons_date <- cbind(power_cons_date, power_time_stamp)

## Making the Sub-metering ~ time plot for 1st Feb 2007 and 2nd Feb 2007
with(power_cons_date, plot(power_time_stamp,as.numeric(Sub_metering_1),  
                           ylab = "Energy sub metering", 
                           xlab ="", type="l"))    
## Adding the line for Sub_metering_2
lines(power_cons_date$power_time_stamp,power_cons_date$Sub_metering_2, col="red")

## Adding the line for Sub_metering_3
lines(power_cons_date$power_time_stamp,power_cons_date$Sub_metering_3, col="blue")

## Adding the legend
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black","red", "blue"), lty=1)

## Close the png file                 
dev.off()
