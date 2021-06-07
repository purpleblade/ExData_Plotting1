# Read the File

power<-read.table("household_power_consumption.txt",sep=";",nrows=92000, 
                    header = TRUE)



# Subset for Feb 1 and 2, 2007

powerFeb<-power[(strptime(power$Date, format="%d/%m/%Y")>=strptime("01/02/2007", format="%d/%m/%Y")
               & strptime(power$Date,format="%d/%m/%Y")<=strptime("02/02/2007", format="%d/%m/%Y")), ]



# Convert Global Active Power from string to numeric

library(dplyr)
powerFeb<-powerFeb %>% mutate(Global_active_power=as.numeric(Global_active_power))



# Plotting Time!

png(file="plot1.png")
hist(powerFeb$Global_active_power, xlab="Global active power (kilowatts)", 
     main = "Global Active Power", col="red")
dev.off()