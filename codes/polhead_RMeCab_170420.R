################################################################################# 
## File Name: polhead_RMecab_170420.R                                          ##
## Date: 20 April 2017                                                         ##
## Author: Gento Kato                                                          ##
## Project: Political Headlines                                                ##
## Purpose: Conduct Isomorphic Analysis and Create Dataset                     ##
################################################################################# 

## Clear Environment
rm(list=ls())

## Prepare Needed Packages
#install.packages ("RMeCab", repos = "http://rmecab.jp/R")
library(RMeCab);library(descr)

## Check Working Directory, and if it is not the location of THIS file, fix it.
#getwd()
setwd("C:/GoogleDrive/Projects/Political Headlines/Political_Headlines_Project/codes")

##########
## Data ##
##########

# Read Text Data
datedata<-read.csv('./../../data/alldate_170420.csv')
# Conduct Keitaiso Kaiseki (Isomorphic Analysis)
MecabRes<-RMeCabDF(dataf=datedata,coln="Headline")

## Save the result
save.image("./../../data/polhead_RMeCab_170420.rda")
