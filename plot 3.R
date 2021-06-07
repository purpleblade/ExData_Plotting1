power<-read.table("household_power_consumption.txt",sep=";",nrows=92000, 
     header = TRUE)



# Subset for Feb 1 and 2, 2007

powerFeb<-power[(strptime(power$Date, format="%d/%m/%Y")>=strptime("01/02/2007", format="%d/%m/%Y")
     & strptime(power$Date,format="%d/%m/%Y")<=strptime("02/02/2007", format="%d/%m/%Y")), ]



# Make a date/time column, make submeters numeric

library(dplyr)
powerFeb<-powerFeb %>% mutate(date_Time=strptime(paste(Date,Time),
                    format="%d/%m/%Y %H:%M:%S"),
                    Sub_metering_1 = as.numeric(Sub_metering_1),
                    Sub_metering_2 = as.numeric(Sub_metering_2),
                    Sub_metering_3 = as.numeric(Sub_metering_3))

# Plot
png(file="plot3.png")
with(powerFeb, plot(date_Time, Sub_metering_1,type="l",
     ylab= "Energy sub metering"))
with(powerFeb,lines(date_Time, Sub_metering_2, col="red"))
with(powerFeb,lines(date_Time, Sub_metering_3, col="blue"))
legend("topright",col=c("black","red","blue"), 
     legend=c("Sub Metering 1","Sub Metering 2","Sub Metering 3"),lty=1)
dev.off()