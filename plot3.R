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

# Plot data (Plot3)

## Data

x <- data$DateTime
y1 <- data$Sub_metering_1
y2 <- data$Sub_metering_2
y3 <- data$Sub_metering_3

## Specify png first, or else dev will mess up the legend

png("plot3.png", width=480, height=480)

## Plot data

plot(x,y1,type="n",xlab = "",ylab = "Energy sub metering", ylim=c(0,max(y1)))
legend("topright", lty = c(1,1), col = c("black", "red", "blue"),legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
lines(x,y1)
lines(x,y2, col = "red")
lines(x,y3, col = "blue")

## Close dev

dev.off()
