## This file reads the measurement of electric power consumption in a 
## household from the given file and creates four plots: 
##    - Global Active Power vs time
##    - Energy Submetering vs time 
##    - Voltage vs time 
##    - Global Reactive Power vs time 
## for the two days - 01-Feb-2007 and 02-Feb-2007

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
png ("plot4.png", width = 480, height = 480, units = "px")

## Making the timestamp and adding it as a column to power_cons_date
power_time_stamp <- as.POSIXct(paste(power_cons_date$Date, power_cons_date$Time), format="%d/%m/%Y %H:%M:%S")
power_cons_date <- cbind(power_cons_date, power_time_stamp)

## 4 plots arranged in 2 rows and 2 columns
par(mfcol=c(2,2))

## Making the Global Active Power ~ time plot for 1st Feb 2007 and 2nd Feb 2007
with(power_cons_date, plot(power_time_stamp,as.numeric(Global_active_power),  
                           ylab = "Global Active Power (kilowatts)", 
                           xlab ="", type="l"))                         

## Making the Sub-metering ~ time plot for 1st Feb 2007 and 2nd Feb 2007
with(power_cons_date, plot(power_time_stamp,as.numeric(Sub_metering_1),  
                           ylab = "Energy sub metering", 
                           xlab ="", type="l"))    
## Adding the line for Sub_metering_2
lines(power_cons_date$power_time_stamp,power_cons_date$Sub_metering_2, col="red")

## Adding the line for Sub_metering_3
lines(power_cons_date$power_time_stamp,power_cons_date$Sub_metering_3, col="blue")

## Adding the legend
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col=c("black","red", "blue"), bty = "n", lty=1, cex=0.9)

## Making the voltage ~ time plot for 1st Feb 2007 and 2nd Feb 2007
with(power_cons_date, plot(power_time_stamp,as.numeric(Voltage),  
                           ylab = "Voltage", 
                           xlab ="datetime", type="l"))  

## Making the Global Reactive Power ~ time plot for 1st Feb 2007 and 2nd Feb 2007
with(power_cons_date, plot(power_time_stamp,as.numeric(Global_reactive_power),
                           ylab = "Global_reactive_power",
                           xlab ="datetime", type="l"))  


## Close the png file                 
dev.off()
