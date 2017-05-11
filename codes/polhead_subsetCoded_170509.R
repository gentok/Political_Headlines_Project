################################################################################# 
## File Name: polhead_subsetCoded_170509.R                                     ##
## Date: 09 May 2017                                                           ##
## Author: Gento Kato                                                          ##
## Project: Political Headlines                                                ##
## Purpose: Add Training Code to Subset Data                                   ##
################################################################################# 

##############################################################################
##############################################################################
## IMPORTANT: MAKE SURE TO OPEN THIS FILE BY CP932(Shift-Jis) TEXT ENCODING ##
##############################################################################
##############################################################################

## Clear Environment
rm(list=ls())

## Prepare Needed Packages
#install.packages ("RMeCab", repos = "http://rmecab.jp/R")
library(rprojroot); library(RMeCab)

## Set Working Directory (As the project folder)
setwd(dirname(rstudioapi::getActiveDocumentContext()$path)); setwd("../") #In RStudio
projdir <- find_root(has_file("README.md")); projdir; setwd(projdir) #In Atom
#setwd("C:/GoogleDrive/Projects/Political_Headlines/Political_Headlines_Project/codes")

##########
## Data ##
##########

## Load Data
cabinetdata <- read.csv("./data_public/cabinetdata.csv")
ldpdata <- read.csv("./data_public/ldpdata.csv")
politicsdata <- read.csv("./data_public/politicsdata.csv")
codeddata <- read.csv("./data_public/codeddata_170509.csv")

#########################
## Add Coded Variables ##
#########################

## Coded subsets 
codedcabinet <- codeddata[-which(is.na(codeddata$cabinetmatch)),]
codedldp <- codeddata[-which(is.na(codeddata$ldpmatch)),]
codedpolitics <- codeddata[-which(is.na(codeddata$politicsmatch)),]

## Replace Old Code Variable
cabinetdata <- cabinetdata[, !(names(cabinetdata) == "codePN")]
ldpdata <- ldpdata[,  !(names(ldpdata) == "codePN")]
politicsdata <- politicsdata[,  !(names(politicsdata) == "codePN")]

## Merge coded variables to the headline subsets
cabinetdata$codeN <- NA
cabinetdata$codeN[codedcabinet$cabinetmatch] <- codedcabinet$codeN
ldpdata$codeN <- NA
ldpdata$codeN[codedldp$ldpmatch] <- codedldp$codeN
politicsdata$codeN <- NA
politicsdata$codeN[codedpolitics$politicsmatch] <- codedpolitics$codeN

## Dummy variable for Training Set
cabinetdata$train <- 0
cabinetdata$train[codedcabinet$cabinetmatch] <- 1
ldpdata$train <- 0
ldpdata$train[codedldp$ldpmatch] <- 1
politicsdata$train <- 0
politicsdata$train[codedpolitics$politicsmatch] <- 1

######################################
## Save Subsets wigh Coded Variable ##
######################################

## Headline Level Data
write.csv(cabinetdata,"./data_public/cabinetdata_traincode.csv", row.names=FALSE)
write.csv(ldpdata,"./data_public/ldpdata_traincode.csv", row.names=FALSE)
write.csv(politicsdata,"./data_public/politicsdata_traincode.csv", row.names=FALSE)