dataset <- read.csv("household_power_consumption.txt", sep = ";")
dataset <- transform(dataset, Date = as.Date(Date, format = "%m/%d/%Y"))
twoDays <- subset(dataset, Date >= as.Date("2007-02-08") & Date <= as.Date("2007-02-09"))
twoDays <- transform(twoDays, Global_active_power = as.numeric(Global_active_power))

png(width = 480, height = 480, filename = "plot1.png")
hist(
  twoDays$Global_active_power,
  col = "red",
  main = "Global Active Power",
  xlab = "Global Active Power (kilowatts)"
)
dev.off()