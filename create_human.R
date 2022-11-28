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
colnames(hd)<-c("hdi.rank","country","hdi","liexp","edu","gni","gni-hdi")
colnames(gii)<-c("gi.rank","country","gii","abr","repre_parl",
                 "sedu_f","sedu_m","lab_f","lab_m")
gii$sedu_rat<-gii$sedu_f/gii$sedu_m
gii$lab_rat<-gii$lab_f/gii$lab_m
#joining the data
human<-inner_join(gii,hd,by="country")
#saving the data
write.csv(human,"./data/human.csv",row.names = F)
#checking if the saving worked
p<-read.csv("./data/human.csv")