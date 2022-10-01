#!/usr/bin/env Rscript
# get filename to work on
# test if there is at least one argument: if not, return an error
if (interactive()) {
  interactive <- interactive()
  interactive
  #probably running on in rstudio so set manually
  #filename <- "targets.csv"
  setwd("/Users/fynn/Documents/Github/Maths/data")
} else {
  #probably running in a docker or similar
  args <- commandArgs(trailingOnly = TRUE)
  if (length(args)==0) {
    stop("At least one argument must be supplied (input file)", call.=FALSE)
  } else {
    filename <- args[1]
  }
}
# Libraries
library(ggplot2)

# create data
xValue <- 1:10
yValue <- cumsum(rnorm(10))
data <- data.frame(xValue,yValue)

# Plot
ggplot(data, aes(x=xValue, y=yValue)) +
  geom_line()


