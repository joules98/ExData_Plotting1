## Get the names of the columns
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
png(filename = "plot2.png",width = 480, height = 480, bg="white")
with(pwrData, plot(datetime, Global_active_power, type = "l", xlab= " " , ylab = "Global Active Power (kilowatts)"))
dev.off()
