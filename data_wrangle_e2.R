#esoini 9.11.2022 / Create_learnign2014
#tidying the data for exercise 2
rm(list = ls())
library(dplyr)

lrn14<-read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt",sep = "\t",header = T)
dim(lrn14)
str(lrn14)
#lrn14 has 183 observations and 60 variables

#2
lrn14$attitude <- lrn14$Attitude / 10
deep_questions <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30","D06",  "D15", "D23", "D31")
lrn14$deep <- rowMeans(lrn14[, deep_questions])
surface_questions <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")
lrn14$surf <- rowMeans(lrn14[, surface_questions])
strategic_questions <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")
lrn14$stra <- rowMeans(lrn14[, strategic_questions])
learning2014 <- lrn14[, c("gender","Age","attitude", "deep", "stra", "surf", "Points")]
colnames(learning2014)[2] <- "age"
colnames(learning2014)[7] <- "points"
#checking the data and removing points == 0
summary(learning2014[c("attitude","stra","deep","surf","points")])
learning2014<-learning2014%>%filter(points>0)

#Setting wd and sacing the data
setwd("/Users/eetusoin/Desktop/IODS/data")
#path="/Users/eetusoin/Desktop/IODS/data/"
write.csv(learning2014,"learning2014.csv", row.names=F)
p<-read.csv("learning2014.csv")

#write.csv(lrn14,paste(path,"learning2014.csv",sep = "", row.names=F))
#m<-read.csv("learning2014.csv")
        


       