#Esoini, 8.12.2022
#Data wrangling 
#libraries
library(dplyr)
library(tidyr)

#loading the data
dat2<-read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt",sep = "\t",header = T)
dat1<-read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt",sep = " ",header = T)
#summaries of the data
summary(dat1)
summary(dat2)
#Brief explanation about the data

####
#Changing to factors
dat1<-dat1 %>% mutate(treatment=as.factor(treatment)) %>%
  mutate(subject= as.factor(subject))
dat2<-dat2 %>% mutate(ID=as.factor(ID)) %>%
  mutate(Group=as.factor(Group))

# For the last plot in the analysis  I have incuded separate id column to indicate 
# participants so that there is no overlap in the id numbers between treatment groups
dat1$id<-1:40
dat1$id<-as.factor(dat1$id)

#Pivoting longer
dat11 <-  pivot_longer(dat1, cols=-c(treatment,subject,id),names_to = "weeks",values_to = "bprs") %>% arrange("subject")
dat21 <-  pivot_longer(dat2, cols=-c(Group, ID),names_to = "time",values_to = "weight") %>% arrange("id")

#
dat11 <-  dat11 %>% mutate(week = as.integer(substr(weeks,5,5)))
dat21 <-  dat21 %>% mutate(time1 = as.integer(substr(time,3,4)))
#In long format subject column has the information about the subject id, each participant may have provided more than one obs in the data, meaning that one participant
#have more than one row. in wide format each participant had one row, and different time variables were presented in their own colums.

#subject/id = participant identification number
#group/treatment = categorical variable that identifies the group/treatment participant was in / received
#week/time = time point in which the observation was taken
#brps= ????
  
write.csv(dat11,"./data/BPRS.csv", row.names=F)
write.csv(dat21, "./data/rats.csv", row.names = F)
  