#Course Project1 for Exploratory Data Analysis
#Script to create [plot2.png]

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
png("plot2.png", height=480, width=480, units="px")

#Draw the plot as needed.
plot(df.elec$Date.Time, df.elec$Global_active_power, type="l", ylab="Global Active Power (kilowatts)", xlab="")

#Turn off the graphics device and bring it back to the screen device.
dev.off()
