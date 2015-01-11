## Get the names of the columns and store them
getColNames <- read.table("household_power_consumption.txt", header=TRUE,sep = ";", nrows=1)

## Read in only the lines for the dates 2007-02-01 and 2007-2-02 and assign column names
pwr <- read.table("household_power_consumption.txt", header = FALSE, sep = ";", 
                  col.names = names(getColNames),
                  colClasses = c(
                          as.Date("Date","%d/%m/%y"), 
                          as.Date("Time","%h/%m/%s"), 
                          as.numeric("Global_active_power"),
                          as.numeric("Global_reactive_power"),
                          as.numeric("Global_intensity"),
                          as.numeric("Sub_metering_1"),
                          as.numeric("Sub_metering_2"),
                          as.numeric("Sub_metering_3")
                  ), 
                  skip=66637, nrows=2880)

## create a combined date and time column and add it to the dataset
datetime<- strptime(paste(pwr$Date, pwr$Time, sep=","), format="%d/%m/%Y,%H:%M:%S")
pwrData <- cbind(pwr,datetime)

## Create PNG file
png(filename = "plot4.png", width = 480, height = 480, bg="white")

## set up device to handle 2 x 2 plots columnwise
par(mfcol = c(2, 2))

## create first plot
with(pwrData, plot(datetime, Global_active_power, type = "l", xlab= " " , ylab = "Global Active Power"))

## create second plot
with(pwrData, plot(datetime, Sub_metering_1, type = "n", xlab = "", ylab = "Energy sub metering"))
with(pwrData, lines(datetime, Sub_metering_1, col = "black"))
with(pwrData, lines(datetime, Sub_metering_2, col = "red"))
with(pwrData, lines(datetime, Sub_metering_3, col = "blue"))
legend("topright", lwd=1, lty= 1, col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

## create third plot
with(pwrData, plot(datetime, Voltage, type = "l"))

## create fourth plot
with(pwrData, plot(datetime, Global_reactive_power, type = "l"))

## clear the device
dev.off()