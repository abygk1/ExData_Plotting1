## This file reads the measurement of electric power consumption in a 
## household from the given file and creates a plot of the 
## Global Active Power value for the two days - 01-Feb-2007 and 02-Feb-2007

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
png ("plot2.png", width = 480, height = 480, units = "px")

## Making the timestamp and adding it as a column to power_cons_date
power_time_stamp <- as.POSIXct(paste(power_cons_date$Date, power_cons_date$Time), format="%d/%m/%Y %H:%M:%S")
power_cons_date <- cbind(power_cons_date, power_time_stamp)

## Making the Global Active Power ~ time plot for 1st Feb 2007 and 2nd Feb 2007
with(power_cons_date, plot(power_time_stamp,as.numeric(Global_active_power),  
                           ylab = "Global Active Power (kilowatts)", 
                           xlab ="", type="l"))                         

## Close the png file                 
dev.off()
