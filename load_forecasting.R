#  Load GFS forecast data
file <- "./Data-GFS/temperature_forecasts.csv"
raw.gfs <- read.csv(file, sep=",")
#  head(raw.gfs)


#  Perform transformations on GFS data:
#   - Convert text dates + times into date-times in the POSIXlt class
gfs.issued.datetime <- strptime(raw.gfs[[1]], format="%m/%d/%y %I:%M %p", tz="GMT")
gfs.valid.datetime  <- strptime(raw.gfs[[2]], format="%m/%d/%y %I:%M %p", tz="GMT")

#   - Assemble transformed columns into a new data frame
forecasts <- data.frame(gfs.issued.datetime, gfs.valid.datetime, raw.gfs[[3]])
names(forecasts) <- c("Issued", "Valid", "Temperature")

#  Select eight weeks of data beginning July 1, 2008



head(raw.gfs[[3]])
head(forecasts[[3]])
summary(forecasts)
sapply(forecasts, class)
names(forecasts)