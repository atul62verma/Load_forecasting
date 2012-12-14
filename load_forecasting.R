library(forecast)   # Automated forecasting functions
library(plyr)       # Allows use of the arrange() function for data sorting
library(reshape)    # Utilities for reshaping data frames and arrays
library(reshape2)   # Utilities for reshaping data frames and arrays

#  Load GFS forecast data
file <- "./Data-GFS/temperature_forecasts_raw"
raw.gfs <- read.csv(file, sep=",")

gfs <- raw.gfs <- read.csv(file, sep=",")
head(raw.gfs)
str(raw.gfs)

#  Perform transformations on GFS data:
#   - Convert text dates + times into date-times in the POSIXt class
# issuedAt <- strptime(raw.gfs[[1]], format="%m/%d/%y %I:%M %p", tz="GMT")
# validFor  <- strptime(raw.gfs[[2]], format="%m/%d/%y %I:%M %p", tz="GMT")
gfs[[1]] <- strptime(raw.gfs[[1]], format="%m/%d/%y %I:%M %p", tz="GMT")
gfs[[2]] <- strptime(raw.gfs[[2]], format="%m/%d/%y %I:%M %p", tz="GMT")
gfs[[3]] <- as.numeric(raw.gfs[[3]])
names(gfs) <- c("issuedAt", "validFor", "Temperature")

str(gfs)

gfs.by.issueTime <- gfs
# gfs.by.issueTime[[1]] <- as.ts(gfs.by.issueTime$issuedAt)
gfs.by.issueTime[[2]] <- as.factor(gfs$validFor - gfs$issuedAt)
names(gfs.by.issueTime) <- c("issuedAt", "leadTimes", "Temperature")

str(gfs.by.issueTime)
summary(gfs.by.issueTime)

head(gfs.by.issueTime)
mgfs <- melt(gfs.by.issueTime,
             )


temp <- c("Temperature")
str(temp)
temp
temp2 <- "Temperature"
str(temp2)
temp2
temp == temp2

#  Reshape into wide tables
temp <- reshape(gfs.by.issueTime, 
                           idvar="issuedAt", 
                           v.names=c("Temperature"),
                           timevar="leadTimes",
                           direction="wide")

str(gfs.by.issueTime$issuedAt)

# gfs.by.validFor <- arrange(gfs,validFor)
# head(gfs.by.validFor)



#   - Assemble transformed columns into a new fcst data frame
leadTimes <- unique(gfs$validFor - gfs$issuedAt)
# lagTimes  <- unique(gfs$issuedAt - gfs$validFor)

leadTimes

# Quick and dirty method to load temp forecasts into fcst array
fcsts.matrix <- matrix(data = gfs$Temperature, 
                       ncol = length(leadTimes), 
                       byrow = TRUE,
                       dimnames = c(as.character(gfs$issuedAt),""))

fcsts[[1]] <- gfs$issuedAt

head(fcsts.matrix)
# forecasts <- data.frame(gfs.issued.datetime, gfs.valid.datetime, raw.gfs[[3]])
# names(forecasts) <- c("Issued", "Valid", "Temperature")

# Select rows containing 1-day-ahead forecasts
# lead.time <- 1
# Lead.times <- (difftime(forecasts$Valid, forecasts$Issued, units="days") == lead.time)
# day.ahead <- forecasts[Lead.times, ]
# 
# #  Convert day ahead forecasts into a time series object
# day.ahead.ts <- as.ts(day.ahead)


head(day.ahead)
day.ahead[1,]
#  forecasts.ts <- as.ts(forecasts)


#  Select eight weeks of data beginning July 1, 2008



head(raw.gfs[[3]])
head(forecasts[[3]])
summary(forecasts)
