# library(forecast)   # Automated forecasting functions
# library(plyr)       # Allows use of the arrange() function for data sorting
# library(reshape)    # Utilities for reshaping data frames and arrays
library(reshape2)   # Utilities for reshaping data frames and arrays
# library(xts)

# Read in function to perform ETL on raw GFS files
fl <- c("rawGfs2castdf.R")
source(fl)

#  Identify file containing the raw GFS forecast data
rawGfsFile <- "./Data-GFS/temperature_forecasts_raw.csv"

#  Load GFS forecast data, transform it, create new data frame
# gfs.castdf <- rawGfs2castdf(rawGfsFile)

# Utilities for testing performance of the rawGfs2castdf function:
# profFile <- tempfile()
# Rprof(profFile) # start gathering profile information
system.time(gfs.castdf <- rawGfs2castdf(rawGfsFile))
# identical(gfs.castdf, gfs.cast)
# Rprof() # stop
# head(summaryRprof(profFile)$by.self)
