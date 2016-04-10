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

# Plot data (Plot2)

x <- data$DateTime
y <- data$Global_active_power
plot(x,y,type="n",xlab = "",ylab = "Global Active Power (kilowatts)")
lines(x,y)

# Create .png file

dev.copy(png, "plot2.png")
dev.off()