dataset <- read.csv("household_power_consumption.txt", sep = ";")
dataset <- transform(dataset, Date = as.Date(Date, format = "%m/%d/%Y"))
twoDays <- subset(dataset, Date >= as.Date("2007-02-21") & Date <= as.Date("2007-02-22"))
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

png(width = 480, height = 480, filename = "plot3.png")

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
dev.off()