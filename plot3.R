# Loading
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, destfile = "household_power_consumption.zip", method = "curl")
consumption <- read.table(unz("household_power_consumption.zip", "household_power_consumption.txt"), 
                          header=T, quote="\"", sep=";", na.strings="?",
                          colClasses=c("character","character","double","double","double","double","double","double","numeric"))
# Formatting
consumption$DateTime = as.POSIXlt(paste(consumption$Date, consumption$Time), format="%d/%m/%Y %H:%M:%S")
consumption$Date = as.Date(strptime(consumption$Date, format="%d/%m/%Y"))

# Plot
png("plot3.png",width=480,height=480)
consFeb <- subset(consumption, Date >= as.Date("2007-02-01") & Date <= as.Date("2007-02-02"))
consFeb <- transform(consFeb, submax = pmax(Sub_metering_1, Sub_metering_2, Sub_metering_3))
with(consFeb, plot(DateTime, submax, type = "n", ylab = "Energy sub metering"))
with(consFeb, points (DateTime, Sub_metering_1, type="l", col = "black"))
with(consFeb, points (DateTime, Sub_metering_2, type="l", col = "red"))
with(consFeb, points (DateTime, Sub_metering_3, type="l", col = "blue"))
legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()
