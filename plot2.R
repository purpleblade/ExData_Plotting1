power<-read.table("household_power_consumption.txt",sep=";",nrows=92000, 
     header = TRUE)



# Subset for Feb 1 and 2, 2007

powerFeb<-power[(strptime(power$Date, format="%d/%m/%Y")>=strptime("01/02/2007", format="%d/%m/%Y")
     & strptime(power$Date,format="%d/%m/%Y")<=strptime("02/02/2007", format="%d/%m/%Y")), ]



# Convert Global Active Power from string to numeric, and make a date/time column

library(dplyr)
powerFeb<-powerFeb %>% mutate(Global_active_power=as.numeric(Global_active_power),
          date_Time=strptime(paste(Date,Time),format="%d/%m/%Y %H:%M:%S"))



# Plot it
png(file="plot2.png")
with(powerFeb, plot(date_Time, Global_active_power, type="l", 
     ylab="Global Active Power (kilowatts)"))
dev.off()