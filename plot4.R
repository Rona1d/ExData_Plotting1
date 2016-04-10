# Create folder named 'data' and jump to that folder

if(!file.exists("data")) {
        dir.create("data")
}
setwd("./data")

# Downloading file...

temp <- tempfile()
fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileURL,temp, mode="wb")
unzip(temp)

# Read the data with subsetting the data

startdate <- "01/02/2007"
rowamnt <- function(days) {
        days*24*60
}
rowamnt(2)

filename <- "household_power_consumption.txt"

data <- read.table(filename,header = FALSE,sep = ";",skip=66637,nrows=rowamnt(2), stringsAsFactors = FALSE)

# Create appropriate columnnames

header <- read.table(filename, nrows = 1, header = FALSE, sep =';', stringsAsFactors = FALSE)
colnames(data) <- unlist(header)

# Create a datetime variable en give date a proper format

data$DateTime <- strptime(paste(data$Date, data$Time, sep = " "),"%d/%m/%Y %H:%M:%S")
data$Date <- as.Date(data$Date, "%d/%m/%Y")

# Plot data (Plot4)

## Data

x <- data$DateTime
y1 <- data$Global_active_power
y2 <- data$Voltage
y3_1 <- data$Sub_metering_1
y3_2 <- data$Sub_metering_2
y3_3 <- data$Sub_metering_3
y4 <- data$Global_reactive_power

## Specify png first, or else dev will mess up the legend

png("plot4.png", width=480, height=480)

## Specify layout of the graph
par(mfrow=c(2,2), mar=c(4,4,1,2), cex.lab=0.9, cex.axis =0.9)

## Plot4.1
plot(x,y1,type="n",xlab = "",ylab = "Global Active Power")
lines(x,y1)

## Plot4.2
plot(x,y2,type="n",xlab = "datetime",ylab = "Voltage", ylim=c(min(y2), max(y2)))
lines(x,y2)

## Plot4.3
plot(x,y3_1,type="n",xlab = "",ylab = "Energy sub metering", ylim=c(0,max(y3_1)))
legend("topright", cex = 0.9,lty = c(1,1), col = c("black", "red", "blue"),legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
lines(x,y3_1)
lines(x,y3_2, col = "red")
lines(x,y3_3, col = "blue")

## Plot4.4
plot(x,y4,type="n",xlab = "datetime",ylab = "Global_reactive_power", ylim=c(min(y4), max(y4)))
lines(x,y4)

## Close dev

dev.off()
