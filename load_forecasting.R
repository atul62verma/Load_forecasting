#  Load GFS forecast data
file <- "./Data-GFS/temperature_forecasts.csv"
raw.gfs <- read.csv(file, sep=",")
# names(raw_data) <- c("VAR1","VAR2","RESPONSE1")

#  Perform transformations on data:
#   - Convert text dates + times into date-times in the POSIXlt class
gfs.issued.datetime <- strptime(raw.gfs[[1]], format="%m/%d/%y %H:%M", tz="GMT")
str(gfs.issued.datetime)

gfs.valid.datetime<- strptime(raw.gfs[[2]], format="%m/%d/%y %H:%M %p", tz="GMT")
str(gfs.valid.datetime)
sapply(gfs.valid.datetime, class)

gfs.valid.datetime$hour[1:10]
#   - Assemble transformed columns into a new data frame

head(raw.gfs)
summary(temperature.forecasts)
sapply(temperature.forecasts, class)