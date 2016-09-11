# Loading
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, destfile = "household_power_consumption.zip", method = "curl")
consumption <- read.table(unz("household_power_consumption.zip", "household_power_consumption.txt"), 
                          header=T, quote="\"", sep=";", na.strings="?",
                          colClasses=c("character","character","double","double","double","double","double","double","numeric"))
# Formatting
consumption$Date = as.Date(strptime(consumption$Date, format="%d/%m/%Y"))

# Plot
png("plot1.png",width=480,height=480)
consFeb <- subset(consumption, Date >= as.Date("2007-02-01") & Date <= as.Date("2007-02-02"))
with(consFeb, hist(Global_active_power, col= "red", 
                   main = "Global Active Power", xlab = "Global Active Power (kilowatts)"))
dev.off()
