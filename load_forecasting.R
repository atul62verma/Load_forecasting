#  Load GFS forecast data
file <- "./Data-GFS/temperature_forecasts.csv"
raw.gfs <- read.csv(file, sep=",")
#  head(raw.gfs)


#  Perform transformations on GFS data:
#   - Convert text dates + times into date-times in the POSIXlt class
gfs.issued.datetime <- strptime(raw.gfs[[1]], format="%m/%d/%y %I:%M %p", tz="GMT")
gfs.valid.datetime  <- strptime(raw.gfs[[2]], format="%m/%d/%y %I:%M %p", tz="GMT")
temperature.forecast <- as.integer(raw.gfs[[3]])
#   - Assemble transformed columns into a new data frame

forecasts <- data.frame(gfs.issued.datetime, gfs.valid.datetime, temperature.forecast)

summary(forecasts)
sapply(forecasts, class)
names(forecasts)