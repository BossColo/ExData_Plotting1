## Set local filename for dataset
filename <- "ElectricConsumption.zip"

## Download and unzip the dataset
if (!file.exists(filename)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(fileURL, filename)
}  
if (!file.exists("household_power_consumption.txt")) { 
  unzip(filename) 
}

## Read titles, then read relevant lines of txt file, setting col.names to the titles read
TabTitles <- read.table('household_power_consumption.txt', sep=';', nrows=1, stringsAsFactors=FALSE)
Feb12 <- read.table('household_power_consumption.txt',col.names = TabTitles, sep=';', skip=66637, nrows=2880, stringsAsFactors=FALSE)

## Convert the Time column into a POSIXct object, and remove the now redundant column Date
Feb12$Time <- as.POSIXct(paste(Feb12$Date, Feb12$Time), format="%d/%m/%Y %H:%M:%S")
Feb12 <- subset(Feb12, select=-Date)

## Open the png graphics device, the default dimension is 480x480 px, so there is no change needed for the assignment
png(filename='plot4.png')

## Set the layout of the figure
par(mfrow=c(2,2))

## Plot the first line graph
with(Feb12, plot(Time, Global_active_power, type='l', xlab='', ylab = 'Global Active Power (kilowatts)'))

## Plot the second line graph
with(Feb12, plot(Time, Voltage, type='l', xlab='datetime', ylab = 'Voltage'))

## Plot the third set of line graphs, setting all parameters so it matches the assignment
with(Feb12, plot(Time, Sub_metering_1, type='l', xlab='', ylab = 'Energy sub metering'))
with(Feb12, lines(Time, Sub_metering_2, col='red'))
with(Feb12, lines(Time, Sub_metering_3, col='blue'))
## Adds the legend with correct lines and colors corresponding to data
legend('topright', legend=c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'), lty=c(1,1,1), col=c('black','red','blue'))

## Plot the fourth line graph
with(Feb12, plot(Time, Global_reactive_power, type='l', xlab='datetime'))

## Close the graphics device and write the file.
dev.off()