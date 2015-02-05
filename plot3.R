# plot3.R

# Part 1 Download, unzip, read, subset and convert data
fileUrl<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"  #URL of data source
download.file(fileUrl, destfile="project1.zip", method="curl") # download file to working directory
unzip("project1.zip") # unzip file, result is .txt file in working directory
consumption<- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings="?") #read complete unzipped file with ; as seperator and "?" as for NA values
projectfile <- subset(consumption, (consumption$Date=="1/2/2007") | (consumption$Date=="2/2/2007"))  # select dates to be analyzed
projectfile$Date<-as.Date(projectfile$Date, format="%d/%m/%Y")  # convert Date row from factor to Date with correct format
# Combining the Date and Time variable and creating a new column in dataset named "DateTime":
projectfile$DateTime <- as.POSIXct(paste(projectfile$Date, projectfile$Time))  # concatenate date and time cols, convert to POSIX and put in new column

# Part 2 Generate .png file with plot
png(file = "plot3.png", width=480, height=480, bg="transparent" )
plot(projectfile$DateTime,projectfile$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering", bg="transparent")
lines(projectfile$DateTime,projectfile$Sub_metering_2, type="l", col="red")
lines(projectfile$DateTime,projectfile$Sub_metering_3, type="l", col="blue")
legend("topright",lty=1,col=c("black","red","blue"), legend =c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"))
dev.off()

