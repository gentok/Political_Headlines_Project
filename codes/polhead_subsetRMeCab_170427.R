################################################################################# 
## File Name: polhead_subsetRMeCab_170427.R                                    ##
## Date: 27 April 2017                                                         ##
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
#setwd("C:/GoogleDrive/Projects/Political_Headlines/Political_Headlines_Project/codes")

##########
## Data ##
##########

## Load Data
load("../data/polhead_RMeCab_170427.rda")

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

#######################
## Seach Topic Texts ##
#######################

## Cabinet / PM ##
cabinetkey <- c("Žñ‘Š", "Š¯“@", "“àŠt", "­Œ ", "­•{", "Št—»", 
                "–@‘Š", "–@–±‘Š", "ŠO–±‘Š", "ŠO‘Š", "à–±‘Š", "à‘Š", 
                "•¶‰È‘Š", "Œú˜J‘Š", "”_…‘Š", "”_‘Š", "ŒoŽY‘Š", "‘Œð‘Š", 
                "ŠÂ‹«‘Š", "–h‰q‘Š", "’·Š¯", "‘å‘ ‘Š", "‘ ‘Š", "Œú¶‘Š", 
                "Œú‘Š", "‰^—A‘Š", "˜J“­‘Š", "˜J‘Š", "ŒšÝ‘Š", "•¶•”‘Š",
                "•¶‘Š", "Œú¶‘Š", "Ž©Ž¡‘Š")
datedata$cabinet<-inclwrd(target=MeCabRes,search=cabinetkey)

## Liberal Democratic Party ##
ldpkey <- c("Ž©–¯", "Ž©–¯“}", "Ž©Œö", "Ž©ŽÐ‚³", "Ž©Œö•Û", "‘Ù", 
            "Š²Ž–’·", "­’²‰ï’·")
datedata$ldp<-inclwrd(target=MeCabRes,search=ldpkey)

## Politics in General ##             
politicskey <- c("–¯ŽåŽå‹`", "‘‰ï", "O‹c‰@", "O‰@", "ŽQ‹c‰@", "ŽQ‰@",
                 "‘I‹“", "’n•û‘I", "­Ž¡", "–@", "“}", "­“}", "—^“}",
                 "–ì“}", "V“}", "“}Žñ", "˜A—§", "‘ã‹cŽm", "‹cˆõ", "’mŽ–", 
                 "Žs’·", "“s‹c", "Œ§‹c", "Žs‹c", "’¬‹c", "‘º‹c", "Žs’¬‘º", 
                 "Ž©Ž¡‘Ì")
datedata$politics<-inclwrd(target=MeCabRes,search=politicskey)

#################
## Subset Data ##
#################

cabinetdata<-subset(datedata, cabinet == 1)
ldpdata<-subset(datedata, ldp == 1)
politicsdata<-subset(datedata, politics == 1)

############################################################################
## Conduct Isomorphic Analysis (Create Word Appearance Matrix) on Subsets ##
############################################################################

cabinetWrdMat <- docMatrixDF(cabinetdata[,"Headline"], 
                             pos = c("–¼ŽŒ","Œ`—eŽŒ","“®ŽŒ","•“®ŽŒ","•ŽŒ",
                                     "Ú‘±ŽŒ","Ú“ªŽŒ","•›ŽŒ","Š´“®ŽŒ"), 
                                      #"‹L†", "ƒtƒBƒ‰[", "‚»‚Ì‘¼"
                             dic="./codes/userdictionary/polword.dic",
                             minFreq = 1)
cabinetWrdMat <- as.data.frame(t(cabinetWrdMat))

ldpWrdMat <- docMatrixDF(ldpdata[,"Headline"], 
                             pos = c("–¼ŽŒ","Œ`—eŽŒ","“®ŽŒ","•“®ŽŒ","•ŽŒ",
                                     "Ú‘±ŽŒ","Ú“ªŽŒ","•›ŽŒ","Š´“®ŽŒ"), 
                                      #"‹L†", "ƒtƒBƒ‰[", "‚»‚Ì‘¼"
                             dic="./codes/userdictionary/polword.dic",
                             minFreq = 1)
ldpWrdMat <- as.data.frame(t(ldpWrdMat))

politicsWrdMat <- docMatrixDF(politicsdata[,"Headline"], 
                             pos = c("–¼ŽŒ","Œ`—eŽŒ","“®ŽŒ","•“®ŽŒ","•ŽŒ",
                                     "Ú‘±ŽŒ","Ú“ªŽŒ","•›ŽŒ","Š´“®ŽŒ"), 
                             #"‹L†", "ƒtƒBƒ‰[", "‚»‚Ì‘¼"
                             dic="./codes/userdictionary/polword.dic",
                             minFreq = 1)
politicsWrdMat <- as.data.frame(t(politicsWrdMat))

#############################################
## Save Exported Subset & Text Matrix Data ##
#############################################

## Headline Level Data
write.csv(cabinetdata,"./data_public/cabinetdata.csv", row.names=FALSE)
write.csv(ldpdata,"./data_public/ldpdata.csv", row.names=FALSE)
write.csv(politicsdata,"./data_public/politicsdata.csv", row.names=FALSE)

## Word Appearance Matirx Data (rows corresponding with headline level data)
write.csv(cabinetWrdMat,"./data_public/cabinetWrdMat.csv", row.names=FALSE)
write.csv(ldpWrdMat,"./data_public/ldpWrdMat.csv", row.names=FALSE)
write.csv(politicsWrdMat,"./data_public/politicsWrdMat.csv", row.names=FALSE)

save(cabinetdata,ldpdata,politicsdata,cabinetWrdMat,ldpWrdMat,politicsWrdMat,
     file = "../data/polhead_subsetRMeCab_170427.rda")