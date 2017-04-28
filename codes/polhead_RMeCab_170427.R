################################################################################# 
## File Name: polhead_RMecab_170427.R                                          ##
## Date: 27 April 2017                                                         ##
## Author: Gento Kato                                                          ##
## Project: Political Headlines                                                ##
## Purpose: Conduct Isomorphic Analysis and Create Dataset                     ##
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

# Read Text Data
datedata<-read.csv('../data/alldate_170420.csv')
# Conduct Keitaiso Kaiseki (Isomorphic Analysis) #using user dictionary
MeCabRes<-RMeCabDF(dataf=datedata,coln="Headline", dic="./codes/userdictionary/polword.dic")

## Save the result
save.image("../data/polhead_RMeCab_170427.rda")
