#  Load GFS forecast data
file <- "./Data-GFS/temperature_forecasts.csv"
raw.gfs <- read.csv(file, sep=",")
# names(raw_data) <- c("VAR1","VAR2","RESPONSE1")
#

#  Perform transformations on data:
#   - Convert text dates + times into date-times in the POSIXlt class
gfs.issued.datetime <- strptime(raw.gfs[[1]], format="%m/%d/%y %I:%M %p", tz="GMT")
gfs.valid.datetime <- strptime(raw.gfs[[2]], format="%m/%d/%y %I:%M %p", tz="GMT")

#   - Assemble transformed columns into a new data frame

forecasts <- c(gfs.issued.datetime, gfs.valid.datetime, raw.gfs[[3]])

head(raw.gfs)
summary(temperature.forecasts)
sapply(temperature.forecasts, class)