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

#convert date/time variables to date/time classes
data$Date <- as.Date(data$Date, format="%d/%m/%Y")
DateTime <- paste(data$Date, data$Time)
data$DateTime <- strptime(DateTime, "%Y-%m-%d %H:%M:%S")
data$DateTime <- as.POSIXct(data$DateTime)

#create plot
png("plot2.png", width=480, height=480)
plot(data$Global_active_power~data$DateTime, type="l", ylab="Global Active Power (kilowatts)", xlab="")
dev.off()
