## Set File Path
setwd("C:/GoogleDrive/Projects/Political_Headlines/data")

############################
## Opening CP932 csv file ##
############################

## Faster Way, using readr package
#install.packages("readr")
library(readr)
options(stringsAsFactors = FALSE)
data1 <- read_csv("alldata_traincode_170510.csv",locale = locale(encoding = "CP932"))
head(data1$Headline) ## Propertly Shown

## Slower Way, using read.csv
data2 <- read.csv("alldata_traincode_170510.csv",fileEncoding = "CP932")
head(data2$Headline) ## Properly Shown

####################################
## Opening CP932 .rda (.rds) file ##
####################################

## For .rda file
allWrdMat10 <- load("allWrdMat10.rda")
## For .rds file
allWrdMat10 <- readRDS("allWrdMat10.rds")

## Re-encode Column Names
Encoding(names(allWrdMat10)) <- "CP932" ## Change Encoding for Column Names
names(allWrdMat10) ## Check