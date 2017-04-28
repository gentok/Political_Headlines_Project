################################################################################# 
## File Name: polhead_textsearch_170420.R                                      ##
## Date: 20 April 2017                                                         ##
## Author: Gento Kato                                                          ##
## Project: Political Headlines                                                ##
## Purpose: Provide tools to search words from texts                           ##
################################################################################# 

## NOTE THAT YOU MAY NEED TO OPEN THIS FILE BY TEXT ENCODING 
## Shift-Jis (CP932) to get coorect texts. 

## Clear Environment
rm(list=ls())

## Prepare Needed Packages
#install.packages ("RMeCab", repos = "http://rmecab.jp/R")
#library(RMeCab);library(descr)

## Check Working Directory, and if it is not the location of THIS file, fix it.
#getwd()
setwd("C:/GoogleDrive/Projects/Political_Headlines/Political_Headlines_Project/codes")

##########
## Data ##
##########

## Load Data
load("./../../data/polhead_RMeCab_170420.rda")

##############################
## Function to Search Texts ##
##############################

## Text finding function
inclwrd<-function(target,search){ ##target=Mecab List, search=set of words to search
  n<-length(target) # Define the length of exporting vector
  countres<-rep(NA,n) # create the exporting vector
  for(i in 1:n){ 
    sample<-as.factor(target[[i]]) # Each element in data value
    levels(sample)[levels(sample) %in%  search]<-"ifindit" # Mark the searching words
    countres[i]<-sum(sample=="ifindit") # word count of searching words
  }
  countres[countres>0]<-1 # make it a dummy variable
  return(countres) # return the vector
}

#########################
## Seach Texts Example ##
#########################

## Economy Frame (Example) ##
search<-c("貿易","投資","ガット","関税","輸入","輸出","禁輸",
          "資本","現地生産","漁業協定","ＷＴＯ","ＦＴＡ","ＡＰＥＣ",
          "援助","支援","円借款","経済","株","相場","円安","円高",
          "終値","市場","赤字","黒字","公共事業","産業","人民元",
          "バブル","円","就業","ドル","ウォン","通商","社","関税","構造協議")
datedata$econ<-inclwrd(target=MecabRes,search=search)

table(datedata$econ)
