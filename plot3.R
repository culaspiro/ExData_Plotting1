#***************************# 
#Exploratory Data Analysis  #
#Course Project 1: Plot 3   #
#***************************#

if(!file.exists("./data")){
  dir.create("./data")
}

#Download the data
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
destfile <-"./data/exdata_data_household_power_consumption.zip"
download.file(fileUrl,destfile)

#Unzip file and save
outDir <- "./EDA"
zipfile <- "./data/exdata_data_household_power_consumption.zip"
unzip(zipfile, exdir=outDir)

#Load the data
datafile <- "./EDA/household_power_consumption.txt"
data <- read.table(datafile, header = TRUE, sep = ";", na.strings = "?")

#dim(data)
#[1] 2075259       9
#head(data)
#str(data)

#Convert the date variable to Date class
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")

#Subset the data
data <- subset(data, subset = (Date >= "2007-02-01" & Date <= "2007-02-02"))

#Convert dates and times
data$datetime <- strptime(paste(data$Date, data$Time), "%Y-%m-%d %H:%M:%S")

data$datetime <- as.POSIXct(data$datetime)

#Create and save plot 3
attach(data)
plot(Sub_metering_1 ~ datetime, type = "l", ylab = "Energy sub metering", xlab = "")
lines(Sub_metering_2 ~ datetime, col = "Red")
lines(Sub_metering_3 ~ datetime, col = "Blue")
legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.copy(png, file = "plot3.png", height = 480, width = 480)
dev.off()
detach(data)