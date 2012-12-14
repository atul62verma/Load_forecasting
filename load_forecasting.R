library(forecast)   # Automated forecasting functions
library(plyr)       # Allows use of the arrange() function for data sorting
library(reshape)    # Utilities for reshaping data frames and arrays
library(reshape2)   # Utilities for reshaping data frames and arrays

#  Load GFS forecast data
file <- "./Data-GFS/temperature_forecasts_raw.csv"
gfs <- raw.gfs <- read.csv(file, sep=",")

str(raw.gfs)
summary(raw.gfs)
raw.gfs[100:120,5]
strptime(raw.gfs[1,4], format="%Y-%m-%d %H:%M", tz="GMT")
#  Perform transformations on GFS data:
#    - Convert forecast temperatures from factor class to numeric class
gfs[[3]] <- as.numeric(raw.gfs[[3]])

#   - Convert text dates + times into date-times in the POSIXlt class
gfs[[4]] <- strptime(raw.gfs[[4]], format="%Y-%m-%d %H:%M", tz="GMT")
gfs[[5]] <- strptime(raw.gfs[[5]], format="%Y-%m-%d %H:%M", tz="GMT")
#      N.B. The time conversion is equivalent to this command:
#         gfs[[colnum]] <- as.POSIXlt(raw.gfs[[colnum]], tz="GMT")
#      However, the strptime() command runs much faster. (Reason: unknown).

#  Create a new column of forecast lead times:
gfs[[6]] <- as.factor(gfs[[5]] - gfs[[4]])

gfs.names <- c("id_forecastDT", "id_site", "Temperature", "issuedAt", "validFor", "leadTime")
str(gfs)
names(gfs) <- gfs.names

str(gfs)

#  Reshape gfs data frame into "long" format



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
