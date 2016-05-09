dataset <- read.csv("household_power_consumption.txt", sep = ";")
dataset <- transform(dataset, Date = as.Date(Date, format = "%m/%d/%Y"))
twoDays <- subset(dataset, Date >= as.Date("2007-02-01") & Date <= as.Date("2007-02-02"))
twoDays <- transform(twoDays, Global_active_power = as.numeric(Global_active_power))
twoDays <- transform(
  twoDays, 
  date_time = as.POSIXct(
    paste(as.character(Date), as.character(Time)),
    format("%Y-%m-%d %H:%M:%S")
  )
)

png(width = 480, height = 480, filename = "plot2.png")
with(
  twoDays, 
  plot(
    date_time, 
    Global_active_power, 
    type = "n", 
    xlab = "", 
    ylab = "Global Active Power (kilowatts)")
)
lines(twoDays$date_time, twoDays$Global_active_power)

dev.off()