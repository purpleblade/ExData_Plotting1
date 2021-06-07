power<-read.table("household_power_consumption.txt",sep=";",nrows=92000, 
     header = TRUE)



# Subset for Feb 1 and 2, 2007

powerFeb<-power[(strptime(power$Date, format="%d/%m/%Y")>=strptime("01/02/2007", format="%d/%m/%Y")
     & strptime(power$Date,format="%d/%m/%Y")<=strptime("02/02/2007", format="%d/%m/%Y")), ]



# Clean Data

library(dplyr)
powerFeb<-powerFeb %>% mutate(date_Time=strptime(paste(Date,Time),
     format="%d/%m/%Y %H:%M:%S"),
     Sub_metering_1 = as.numeric(Sub_metering_1),
     Sub_metering_2 = as.numeric(Sub_metering_2),
     Sub_metering_3 = as.numeric(Sub_metering_3),
     Global_active_power = as.numeric(Global_active_power),
     Voltage = as.numeric(Voltage),
     Global_reactive_power = as.numeric(Global_reactive_power))
 
# Plot
png(file="plot4.png")
par(mfrow=c(2,2))
with(powerFeb, plot(date_Time, Global_active_power, type="l", 
     ylab="Global Active Power",xlab=""))

with(powerFeb,plot(date_Time, Voltage, type="l",xlab = "datetime"))

with(powerFeb, plot(date_Time, Sub_metering_1,type="l",
     ylab= "Energy sub metering",xlab=""))
with(powerFeb,lines(date_Time, Sub_metering_2, col="red"))
with(powerFeb,lines(date_Time, Sub_metering_3, col="blue",xlab=""))
legend("topright",col=c("black","red","blue"), 
     legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=1,bty="n")


with(powerFeb,plot(date_Time,Global_reactive_power,type="l",xlab = "datetime"))
dev.off()