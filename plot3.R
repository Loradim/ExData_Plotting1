library (readr)
library (lubridate)

# download file if not previously downloaded
if (!file.exists("household_power_consumption.zip")) {
    download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile = "household_power_consumption.zip")
}

# load and subset data
fulldata <- read_csv2("household_power_consumption.zip", na = "?", col_types = "ccnnnnnnn")
fulldata$CompleteDate <- dmy_hms(paste(fulldata$Date, fulldata$Time))
fulldata$Date <- as.Date(dmy(fulldata$Date))
ds <- subset(fulldata, Date == dmy("01/02/2007") | Date == dmy("02/02/2007"))

# create png with hist plot about global active power
png(filename = "plot3.png", width = 480, height = 480)
plot(pmax(ds$Sub_metering_1, ds$Sub_metering_2, ds$Sub_metering_3) ~ ds$CompleteDate, type = "n", xlab = "Day of Week", ylab = "Energy sub metering")
lines(ds$CompleteDate, ds$Sub_metering_1, col = "black")
lines(ds$CompleteDate, ds$Sub_metering_2, col = "red")
lines(ds$CompleteDate, ds$Sub_metering_3, col = "blue")
legend("topright", col = c("black", "red", "blue"),legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = 1)
dev.off()
