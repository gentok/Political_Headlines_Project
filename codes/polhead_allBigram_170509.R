################################################################################# 
## File Name: polhead_allBigram_170509.R                                       ##
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

## Bigram
allBigram20t <- docNgramDF(datedata[,"Headline"], N=2,
                          pos = c("名詞","形容詞","動詞"), 
                          #"助動詞","助詞","接続詞","接頭詞","副詞","感動詞""記号", "フィラー", "その他"
                          dic="./codes/userdictionary/polword.dic",
                          minFreq = 20)
#allBigram10 <- t(allBigram10)

## Save the result
save(allBigram20t, file="../allBigram20t.rda")
saveRDS(allBigram20t, "../data/allBigram20t.rds")
