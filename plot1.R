library (readr)
library (lubridate)

# download file if not previously downloaded
if (!file.exists("household_power_consumption.zip")) {
    download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile = "household_power_consumption.zip")
}

# load and subset data
fulldata <- read_csv2("household_power_consumption.zip", na = "?", col_types = "ccnnnnnnn")
fulldata$Date <- as.Date(dmy(fulldata$Date))
ds <- subset(fulldata, Date == dmy("01/02/2007") | Date == dmy("02/02/2007"))

# create png with hist plot about global active power
png(filename = "plot1.png", width = 480, height = 480)
hist(ds$Global_active_power, col = "red", main = "Global active power", xlab = "Global active power (kilowatts)")
dev.off()
