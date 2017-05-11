################################################################################# 
## File Name: polhead_subsetCodingSample_170509.R                              ##
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
cabinetdata <- read.csv("./data_public/cabinetdata.csv")
ldpdata <- read.csv("./data_public/ldpdata.csv")
politicsdata <- read.csv("./data_public/politicsdata.csv")

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
codingcabinet <- samplecoding(cabinetdata, 500)
codingldp <- samplecoding(ldpdata, 500)
codingpolitics <- samplecoding(politicsdata, 500)

#########################
## Save Coding Subsets ##
#########################

## Coding Data ##
write.csv(codingcabinet,"./data_public/codingcabinet_170509.csv", row.names=FALSE)
write.csv(codingldp,"./data_public/codingldp_170509.csv", row.names=FALSE)
write.csv(codingpolitics,"./data_public/codingpolitics_170509.csv", row.names=FALSE)