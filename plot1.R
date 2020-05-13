#download data and save to "Data" folder

if (!file.exists("data")) {
  dir.create("data")
} 

fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, destfile = "./data/Electric Power Consumption.zip")
zipFile <- "./data/Electric Power Consumption.zip"
unzip(zipFile)


#read and subset data
data <- read.table("household_power_consumption.txt", header=TRUE, na.strings="?", sep=";")
data <- data[(data$Date=="1/2/2007" | data$Date=="2/2/2007"),]

#create plot
png("plot3.png", width=480, height=480)
hist(data$Global_active_power, xlab="Global Active Power (kilowatts)", ylab="Frequency", main="Global Active Power", col="red")
dev.off()
