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
png(filename = "plot2.png", width = 480, height = 480)
plot(ds$Global_active_power ~ ds$CompleteDate, type = "l", ylab = "Global active power (kilowatts)", xlab = "Day of Week", main = "Power consumption per day")
mtext("Days are in Germany, sorry for that")
dev.off()