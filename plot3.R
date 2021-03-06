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
png("plot3.png", width=480, height=480)
with(data,{plot(x=DateTime, y = Sub_metering_1, type="l", col = "black", xlab="", ylab="Energy sub metering")
          lines(x=DateTime, y = Sub_metering_2, type="l", col = "red")
          lines(x=DateTime, y = Sub_metering_3, type="l", col = "blue")
          legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"))
     })
dev.off()
