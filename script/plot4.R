dataset <- read.csv("household_power_consumption.txt", sep = ";")
dataset <- transform(dataset, Date = as.Date(Date, format = "%m/%d/%Y"))
twoDays <- subset(dataset, Date >= as.Date("2007-02-01") & Date <= as.Date("2007-02-02"))

twoDays <- transform(twoDays, Global_active_power = as.numeric(Global_active_power))
twoDays <- transform(twoDays, Global_reactive_power = as.numeric(Global_reactive_power))
twoDays <- transform(twoDays, Voltage = as.numeric(Voltage))
twoDays <- transform(twoDays, Sub_metering_3 = as.numeric(Sub_metering_3))
twoDays <- transform(twoDays, Sub_metering_1 = as.numeric(Sub_metering_1))
twoDays <- transform(twoDays, Sub_metering_2 = as.numeric(Sub_metering_2))
twoDays <- transform(twoDays, Sub_metering_3 = as.numeric(Sub_metering_3))
twoDays <- transform(
  twoDays, 
  date_time = as.POSIXct(
    paste(as.character(Date), as.character(Time)),
    format("%Y-%m-%d %H:%M:%S")
  )
)

png(width = 480, height = 480, filename = "plot4.png")
par(mfrow = c(2,2))

with(
  twoDays, 
  plot(
    date_time, 
    Global_active_power, 
    type = "n", 
    ylab = "Global Active Power",
    xlab = ""
  )
)
with(twoDays, lines(date_time, Global_active_power, ylab = "Global Active Power"))
with(
  twoDays, 
  plot(
    date_time, 
    Voltage, 
    type = "n", 
    xlab = ""
  )
)
with(twoDays, lines(date_time, Voltage))

with(
  twoDays, 
  plot(
    date_time, 
    Sub_metering_3, 
    type = "n", 
    ylab = "Energy sub metering",
    xlab = ""
  )
)

with(twoDays, {
  lines(date_time, Sub_metering_2, col = "red")
  lines(date_time, Sub_metering_3, col = "blue")
  lines(date_time, Sub_metering_1)
}
)

legend(
  "topright", 
  col = c("black", "red", "blue"), 
  legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
  lty = c(1,1,1),
  cex = 0.5
)

with(
  twoDays, 
  plot(
    date_time, 
    Global_reactive_power, 
    type = "n",
    xlab = "datetime"
  )
)

with(twoDays, lines(date_time, Global_reactive_power))

dev.off()
