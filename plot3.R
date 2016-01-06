# R code to produce plot 3, assuming the working directory is set to that of 
# the downloaded data folder "./exdata-data-household_power consumption"
#
# Set name of data file, open connection to it and find lines for the dates
# interest (2007-02-01 & 2007-02-02)
#
filename <- "household_power_consumption.txt"
con <- file(filename)
index <- grep("^1/2/2007|^2/2/2007",readLines(con))
#
# Extract raw data for the dates and add column names for variables
#
projData <- read.table(filename, sep = ";", skip = (index[1]-1),
                       nrows = length(index),na.strings = "?",
                       stringsAsFactors = FALSE)
names <- read.table(filename, sep = ";",nrows = 1,stringsAsFactors = FALSE)
colnames(projData) <- names[1,]
rm(names,filename,index)
close(con)
rm(con)
#
# Change classes of time and date and combine into one variable (tidy data)
#
library(lubridate)
date <- dmy_hms(paste(projData[,1],projData[,2],sep = " "))
projData <- data.frame(date,projData[,-(1:2)],stringsAsFactors = FALSE)
rm(date)
#
# Set up png file
#
png(filename = "plot3.png",width = 480, height = 480)
#
# Plot figure 3 and close png device
#
with(projData,plot(date,Sub_metering_1, xlab = "",
                   ylab = "Energy sub metering", type = "n"))
with(projData,lines(date,Sub_metering_1,col = "black"))
with(projData,lines(date,Sub_metering_2,col = "red"))
with(projData,lines(date,Sub_metering_3,col = "blue"))
legend("topright",col = c("black","red","blue"),
       lty = 1, legend = names(projData[6:8]))
dev.off()