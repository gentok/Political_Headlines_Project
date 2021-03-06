################################################################################# 
## File Name: polhead_subsetRMeCab_170509.R                                    ##
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
load("../data/polhead_allRMeCab_170427.rda")

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
cabinetkey <- c("��", "���@", "���t", "����", "���{", "�t��", 
                "�@��", "�@����", "�O����", "�O��", "������", "����", 
                "���ȑ�", "���J��", "�_����", "�_��", "�o�Y��", "����", 
                "����", "�h�q��", "����", "�呠��", "����", "������", 
                "����", "�^�A��", "�J����", "�J��", "���ݑ�", "������",
                "����", "������", "������")
datedata$cabinet<-inclwrd(target=MeCabRes,search=cabinetkey)

## Liberal Democratic Party ##
ldpkey <- c("����", "�����}", "����", "���Ђ�", "������", "����", 
            "������", "�����")
datedata$ldp<-inclwrd(target=MeCabRes,search=ldpkey)

## Politics in General ##             
politicskey <- c("�����`", "����", "�O�c�@", "�O�@", "�Q�c�@", "�Q�@",
                 "�I��", "�n���I", "����", "�@", "�}", "���}", "�^�}",
                 "��}", "�V�}", "�}��", "�A��", "��c�m", "�c��", "�m��", 
                 "�s��", "�s�c", "���c", "�s�c", "���c", "���c", "�s����", 
                 "������")
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

cabinetWrdMat10 <- docMatrixDF(cabinetdata[,"Headline"], 
                             pos = c("����","�`�e��","����","������","����",
                                     "�ڑ���","�ړ���","����","������"), 
                                      #"�L��", "�t�B���[", "���̑�"
                             dic="./codes/userdictionary/polword.dic",
                             minFreq = 10)
cabinetWrdMat10 <- as.data.frame(t(cabinetWrdMat10))

ldpWrdMat10 <- docMatrixDF(ldpdata[,"Headline"], 
                             pos = c("����","�`�e��","����","������","����",
                                     "�ڑ���","�ړ���","����","������"), 
                                      #"�L��", "�t�B���[", "���̑�"
                             dic="./codes/userdictionary/polword.dic",
                             minFreq = 10)
ldpWrdMat10 <- as.data.frame(t(ldpWrdMat10))

politicsWrdMat10 <- docMatrixDF(politicsdata[,"Headline"], 
                             pos = c("����","�`�e��","����","������","����",
                                     "�ڑ���","�ړ���","����","������"), 
                             #"�L��", "�t�B���[", "���̑�"
                             dic="./codes/userdictionary/polword.dic",
                             minFreq = 10)
politicsWrdMat10 <- as.data.frame(t(politicsWrdMat10))

#############################################
## Save Exported Subset & Text Matrix Data ##
#############################################

## Headline Level Data
write.csv(cabinetdata,"./data_public/cabinetdata.csv", row.names=FALSE)
write.csv(ldpdata,"./data_public/ldpdata.csv", row.names=FALSE)
write.csv(politicsdata,"./data_public/politicsdata.csv", row.names=FALSE)

## Word Appearance Matirx Data (rows corresponding with headline level data)
write.csv(cabinetWrdMat10,"./data_public/cabinetWrdMat10.csv", row.names=FALSE)
write.csv(ldpWrdMat10,"./data_public/ldpWrdMat10.csv", row.names=FALSE)
write.csv(politicsWrdMat10,"./data_public/politicsWrdMat10.csv", row.names=FALSE)

save(datedata, cabinetdata, ldpdata, politicsdata, 
     cabinetWrdMat10, ldpWrdMat10, politicsWrdMat10,
     file = "../data/polhead_subsetRMeCab_170509.rda")
