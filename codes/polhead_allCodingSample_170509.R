################################################################################# 
## File Name: polhead_allCodingSample_170509.R                                 ##
## Date: 09 May 2017                                                           ##
## Author: Gento Kato                                                          ##
## Project: Political Headlines                                                ##
## Purpose: Subset Data and Create Text Appearance Matrix                      ##
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
#setwd("C:/GoogleDrive/Projects/Political_Headlines/Political_Headlines_Project")

##########
## Data ##
##########

## Load Data
# Read Text Data
datedata<-read.csv('../data/alldate_170420.csv')

#############################
## Sample Coding Headlines ##
#############################

## Sample n rows from each subset
samplecoding <- function(targetdata, n, seed = 45349){
  set.seed(seed)
  sampleloc <- sample(seq(1,dim(targetdata)[1],1), n)
  codingtarget <- data.frame(id_all = targetdata$id_all[sampleloc], 
                             Headline = targetdata$Headline[sampleloc],
                             codeN = NA, missword = NA,
                             sampleloc = sampleloc)
  return(codingtarget)
}

## Create Coding Data
codingall <- samplecoding(datedata, 1000)

#########################
## Save Coding Subsets ##
#########################

## Coding Data ##
write.csv(codingall,"./data_public/codingall_170509.csv", row.names=FALSE)