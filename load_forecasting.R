# library(forecast)   # Automated forecasting functions
# library(plyr)       # Allows use of the arrange() function for data sorting
library(reshape)    # Utilities for reshaping data frames and arrays
library(reshape2)   # Utilities for reshaping data frames and arrays
library(xts)

#  Load GFS forecast data
file <- "./Data-GFS/temperature_forecasts_raw.csv"
gfs <- raw.gfs <- read.csv(file, sep=",")

#  Perform transformations on GFS data:
#   - Convert text dates + times into date-times in the POSIXlt class
#   - Replace initial_datetime with new column of forecast lead/lag times
#   - Convert forecast temperatures from factor class to numeric class
#   - Reorder columns; add new column labels
gfs[[4]] <- strptime(raw.gfs[[4]], format="%Y-%m-%d %H:%M", tz="GMT")
gfs[[5]] <- strptime(raw.gfs[[5]], format="%Y-%m-%d %H:%M", tz="GMT")
gfs[[2]] <- as.factor(gfs[[5]] - gfs[[4]])
gfs[[1]] <- as.factor(raw.gfs[[5]])
gfs <- gfs[,1:3]

names(gfs) <- c("validFor", "hoursAhead", "Temperature")

str(gfs)
head(gfs)
tail(gfs)

#  Reshape gfs data frame into "long" format
gfs.molten <- melt(gfs, id=c("validFor","hoursAhead")) 

unique(gfs.molten$variable)

gfs.cast <- cast(gfs.molten, ... ~ hoursAhead)

head(gfs.cast)
str(gfs.cast)

summary(gfs.cast)
gfs.cast[1,]
gfs.cast[101:110, ]
head(gfs.cast)
tail(gfs.cast)

#  Since for this application all forecasts correspond to the same spatial location
#  (id_site==112, for NYC/LGA), we'll remove it to cut down on clutter.


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
