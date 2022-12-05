
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
tail(dat,)
#last 7 obs relate to regions->  removing those
last<-nrow(dat)-7
dat<-dat[1:last,]

# add countries as rownames
rownames(dat) <- dat$country
#removing country-variable
dat<-dat[,-1]

#saving the data
write.csv(dat,"./data/human2.csv",row.names = T)
