#!/usr/bin/env Rscript
# get filename to work on
# test if there is at least one argument: if not, return an error
if (interactive()) {
  interactive <- interactive()
  interactive
  #probably running on in rstudio so set manually
  filename <- "targets.csv"
  setwd("/")
} else {
  #probably running in a docker or similar
  args <- commandArgs(trailingOnly = TRUE)
  if (length(args)==0) {
    stop("At least one argument must be supplied (input file)", call.=FALSE)
  } else {
    filename <- args[1]
  }
}

library(dplyr, warn.conflicts = FALSE)
library(tidygeocoder)
library(tools)
library(readxl)
library(ggplot2)
library(openxlsx)

pdf(NULL)
opar <- par() 
filenameNoExt <- file_path_sans_ext(basename(filename))
outputfile <- paste0(filenameNoExt,"-GEO.csv")
my_startrow <- 1

#import and prepare the data
csvdata <- read.csv(filename)
#csvdata <- read.xlsx(filename, 
#                     sheet = 1,
#                     startRow = my_startrow,
#                     detectDates = TRUE,
#                     colNames = TRUE,
#                     skipEmptyRows = TRUE,
#                     skipEmptyCols = TRUE,
#                     sep.names = "_" 
#)

for(i in 1:nrow(csvdata))
{
  # Print("Working...")
  result <- geocode(
    csvdata,
    street = Street,
    country = Country,
    postalcode = ZIP,
    city = City,
    state = State,
    )
  show(result)
  csvdata$long[i] <- result[1]
  csvdata$lat[i] <- result[2]
  csvdata$geoAddress[i] <- result[3]
}
