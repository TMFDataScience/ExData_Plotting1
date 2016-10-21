## Create special folder for this file
if(!file.exists("./BasePlot")){dir.create("./BasePlot")}
## If file doesn't exist, download it
if(!file.exists("./BasePlot/household_power_consumption.txt")){
  ## Get URL of zip file
  fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  ## Download file
  download.file(fileUrl,destfile = "./BasePlot/ElectricPowerConsumption.zip")
  ## Unzip file into text file, overwriting the file if this has already been downloaded
  unzip("./BasePlot/ElectricPowerConsumption.zip", overwrite = TRUE, exdir = "./BasePlot")
}
## Now read data into dataframe
plotData <- read.table("./BasePlot/household_power_consumption.txt", header = TRUE, sep = ";", colClasses = "character", na.strings = c("?"))
## Remove lines not required
plotData <- subset(plotData, Date == "1/2/2007" | Date == "2/2/2007")
## Create variable with R date format, and get weekday
plotData$RDate <- as.POSIXct(strptime(paste(plotData$Date, plotData$Time), "%d/%m/%Y %H:%M:%S"))
## Define graphics device 
png("./BasePlot/plot1.png", width = 480, height = 480)
## Now display histogram
hist(as.numeric(plotData$Global_active_power), col="red", breaks = 12, main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
## close device
dev.off()
