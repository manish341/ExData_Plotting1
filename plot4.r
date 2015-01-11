#Course Project1 for Exploratory Data Analysis
#Script to create [plot4.png]

#Getting data
df.elec<-read.table("household_power_consumption.txt", sep=";", na.strings="?", stringsAsFactors=F, colClasses=c(rep("character", 2), rep("numeric",7)), header=T)

#Cleaning Data, removing mission values
df.good<-complete.cases(df.elec)
df.elec<-df.elec[df.good,]
rm(df.good)

#Coercing [Date] field as date
df.elec$Date<-as.Date(df.elec$Date, "%d/%m/%Y")

#Subsetting data as we only need the data for two days
df.elec<-df.elec[df.elec$Date=="2007-02-01" | df.elec$Date=="2007-02-02",]

#Create field Date.Time
df.elec$Date.Time <- strptime(paste(df.elec$Date, df.elec$Time , sep = " "),"%Y-%m-%d %H:%M:%S")

#Change the graphics device to png.
png("plot4.png", height=480, width=480, units="px")

#Set the mfrow for 2 rows and 2 columns, so that we can create 4 plots on the same device
par(mfrow=c(2,2))

############# DRAW PLOT1 ###############
plot(df.elec$Date.Time, df.elec$Global_active_power, type="l", ylab="Global Active Power", xlab="")

############# DRAW PLOT2 ###############
plot(df.elec$Date.Time, df.elec$Voltage, type="l", ylab="Voltage", xlab="datetime")

############# DRAW PLOT3 ###############
plot(df.elec$Date.Time, df.elec$Sub_metering_1, type="n", ylab="Energy sub metering", xlab="")
lines(df.elec$Date.Time, df.elec$Sub_metering_1)
lines(df.elec$Date.Time, df.elec$Sub_metering_2, col="red")
lines(df.elec$Date.Time, df.elec$Sub_metering_3, col="blue")

legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black", "red", "blue"), lty=1:1,  lwd=c(1.5,1.5,1.5))

############# DRAW PLOT4 ###############
plot(df.elec$Date.Time, df.elec$Global_reactive_power, type="l", ylab="Global_reactive_power", xlab="datetime")

#Turn off the graphics device and bring it back to the screen device.
dev.off()
