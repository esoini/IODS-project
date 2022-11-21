#Eetu Soini/w3_Data_wrangling/ 17/11/12
#P. Cortez and A. Silva. Using Data Mining to Predict Secondary School Student Performance. In A. Brito and J. Teixeira Eds., Proceedings of 5th FUture BUsiness TEChnology Conference (FUBUTEC 2008) pp. 5-12, Porto, Portugal, April, 2008, EUROSIS, ISBN 978-9077381-39-7.

#Read the data to variables dat1 and dat2
d1=read.table("./data/student-mat.csv",sep=";",header=TRUE)
d2=read.table("./data/student-por.csv",sep=";",header=TRUE)

# Colums to be removed
removables<-c("failures", "paid", "absences", "G1", "G2", "G3")

# the rest of the columns are common identifiers used for joining the data sets
keep <- setdiff(colnames(d1), removables)

# inner join_
d3<- inner_join(d1,d2, by = keep)
#dimensions 
dim(d1)
dim(d2)
dim(d3)
#dat1= 395 obs, 33 variable
#dat2= 649 obs, 33 variable
#dat3= 370 obs , 39 variables, of which 10 are duplicates

#Removing columns that end with ".x" or ".y"
d4 <- d3 %>% select(-contains(c(".x",".y")))

#Creating alc_use and HIgh_use
d4<- d4%>%mutate(alc_use= (Dalc+Walc)/2)%>%
  mutate(high_use=alc_use > 2)
#saving the data 
write_csv(d4,"./data/alc.csv")
#checking if everything works
f<-read_csv("./data/alc.csv")