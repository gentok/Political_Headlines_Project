################################################################################# 
## File Name: polhead_monthdata_170420.R                                       ##
## Date: 20 April 2017                                                         ##
## Author: Gento Kato                                                          ##
## Project: Political Headlines                                                ##
## Purpose: Aggregate and Create Monthly Dataset                               ##
################################################################################# 

## Clear Environment
rm(list=ls())

## Prepare Needed Packages
#install.packages ("RMeCab", repos = "http://rmecab.jp/R")
library(descr);library(doBy)

## Check Working Directory, and if it is not the location of THIS file, fix it.
#getwd()
setwd("C:/GoogleDrive/Projects/Political_Headlines/Political_Headlines_Project/codes")

##########
## Data ##
##########

# Read Text Data
datedata<-read.csv('./../../data/alldate_170420.csv')

## Decompose PN codes into positive and negative
datedata$codeP <- ((datedata$codePN)^2 + datedata$codePN)/2 # Positive Code Dummy
datedata$codeN <- ((datedata$codePN)^2 - datedata$codePN)/2 # Negative Code Dummy

## Weight codes by word count
datedata$codePNw <- datedata$codePN * datedata$wcount # Word Count * PN code
datedata$codePw <- datedata$codeP * datedata$wcount # Word Count * Positive code
datedata$codeNw <- datedata$codeN * datedata$wcount # Word Count * Negative code

## Monthly PN Code Data
monthdata<-summaryBy(wcount + codePN + codeP + codeN + 
                     codePNw + codePw + codeNw ~ jijiymonth, 
                     data=datedata, FUN=c(mean, sum),keep.names=TRUE,na.rm=TRUE)
monthdata$time<-seq(1:329)

## Jiji Monthly Poll Data
jijidata<-read.csv("./../../data/Jiji_simplified_160213_8711to1503.csv")
jijidata$econbetter<-jijidata$econpast_better+jijidata$econpast_swbetter
jijidata$econworse<-jijidata$econpast_worse+jijidata$econpast_swworse
jijidata$lifeeasy<-jijidata$lifepast_easy+jijidata$lifepast_sweasy
jijidata$lifedifficult<-jijidata$lifepast_difficult+jijidata$lifepast_swdifficult
jijidata$time<-seq(1:329)

save.image("./../../data/polhead_monthdata_170420.rda")