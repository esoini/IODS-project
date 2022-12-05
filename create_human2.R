#esoini
#datawrangle 
library(dplyr)
hd <- read.csv("https://raw.githubusercontent.com/KimmoVehkalahti/Helsinki-Open-Data-Science/master/datasets/human_development.csv")
gii <- read.csv("https://raw.githubusercontent.com/KimmoVehkalahti/Helsinki-Open-Data-Science/master/datasets/gender_inequality.csv", na = "..")
#exploring the data
dim(hd)
str(hd)
dim(gii)
str(gii)
summary(hd)
summary(gii)
#renaming the variables
colnames(hd)<-c("hdi.rank","country","hdi","liexp","edu","medu","gni","gni-hdi")
colnames(gii)<-c("gii.rank","country","gii","mat_mor","abr","repre_parl",
                 "sedu_f","sedu_m","lab_f","lab_m")
gii$sedu_rat<-gii$sedu_f/gii$sedu_m
gii$lab_rat<-gii$lab_f/gii$lab_m
#joining the data
human<-inner_join(gii,hd,by="country")
#saving the data
write.csv(human,"./data/human.csv",row.names = F)
#checking if the saving worked
p<-read.csv("./data/human.csv")

#####################
#Week5
#####################

#libraries
library(dplyr)
library(stringr)

#Loading the data
dat<-read.csv("./data/human.csv")
                                                                                                
#Mutating gni, replacing commas and changing class to numeric 
dat$gni<-str_replace(dat$gni, pattern = ",",replace="") %>% as.numeric

#variables to keep
keep<-c("country","sedu_rat","lab_rat","edu","liexp","gni","mat_mor","abr","repre_parl")
#selectin variables
dat <- select(dat, one_of(keep))

#Removing missing values
dat<-dat[complete.cases(dat),]

#checking how many of the obs are realted regions rather than countries
tail(dat)
#last 7 obs relate to regions->  removing those
last<-nrow(dat)-7
dat<-dat[1:last,]

# add countries as rownames
rownames(dat) <- dat$country
#removing country-variable
dat<-dat[,-1]

#saving the data
write.csv(dat,"./data/human2.csv",row.names = T)
