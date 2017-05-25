################################################################################# 
## File Name: polhead_allWrdMat_170509.R                                       ##
## Date: 09 May 2017                                                           ##
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
library(rprojroot); library(RMeCab); library(readr)

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
allWrdMat10 <- docMatrixDF(datedata[,"Headline"], 
                               pos = c("名詞","形容詞","動詞"), 
                               #"助動詞","助詞","接続詞","接頭詞","副詞","感動詞""記号", "フィラー", "その他"
                               dic="./codes/userdictionary/polword.dic",
                               minFreq = 10)
allWrdMat10 <- as.data.frame(t(allWrdMat10))

## Save the result
saveRDS(allWrdMat10,"../data/allWrdMat10.rds")
write.csv(allWrdMat10, file=gzfile("../data/allWrdMat10.csv.gz"), 
          fileEncoding = "CP932", row.names = FALSE)
#write_csv(allWrdMat10, file.path("../", "allWrdMat10.csv.gz"))