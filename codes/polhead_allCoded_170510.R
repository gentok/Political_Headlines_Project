################################################################################# 
## File Name: polhead_allCoded_170510.R                                        ##
## Date: 10 May 2017                                                           ##
## Author: Gento Kato                                                          ##
## Project: Political Headlines                                                ##
## Purpose: Merge Coding with All Date Dataset                                 ##
################################################################################# 

##############################################################################
##############################################################################
## IMPORTANT: MAKE SURE TO OPEN THIS FILE BY CP932(Shift-Jis) TEXT ENCODING ##
##############################################################################
##############################################################################

## Clear Environment
rm(list=ls())

## Prepare Needed Packages
library(rprojroot)

## Set Working Directory (As the project folder)
setwd(dirname(rstudioapi::getActiveDocumentContext()$path)); setwd("../") #In RStudio
projdir <- find_root(has_file("README.md")); projdir; setwd(projdir) #In Atom
#setwd("C:/GoogleDrive/Projects/Political_Headlines/Political_Headlines_Project")

##########
## Data ##
##########

# Read Text Data
alldata<-read.csv('../data/alldate_170420.csv')
codeddata <- read.csv('./data_public/codedall_170509.csv')

## Remove the Last PN Code
alldata <- alldata[,!(names(alldata) == "codePN")]

## Add New Negative Code
alldata$codeN = NA
alldata$codeN[codeddata$sampleloc] <- codeddata$codeN

## Training Data Dummy
alldata$train = 0
alldata$train[codeddata$sampleloc] <- 1

###############
## Save Data ##
###############

write.csv(alldata, "../data/alldata_traincode_170510.csv")

