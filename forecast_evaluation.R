#  FILE forecast_evaluation.R
#  An R program to perform statistical analysis of the accuracy of the GFS
#  forecasting system.
#    Forecast model: Mean of the ensemble MOS of NOAA's GFS
#    Variable: Hourly temperatures at NY's LGA airport, 2000-05-30 -- 2012-03-03
#    Observations: Records from NOAA/NCDC
#

# library(plyr)       # Allows use of the arrange() function for data sorting
# library(reshape)    # Utilities for reshaping data frames and arrays
library(reshape2)   # Utilities for reshaping data frames and arrays
library(xts)
library(plyr)

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
