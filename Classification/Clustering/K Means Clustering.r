x <- runif(50)
x
y <- runif(50)
y
data <- cbind(x,y)
data
plot(data)
text(data,rownames(data))
km <- kmeans(data,4)
str(km)
#install.packages("animation")
library(animation)
kmeans.ani(data,4)
km1<-kmeans(data,4)
km1$withinss
km1$betweensskmeans.ani(data,5)
km2<-kmeans(data,5)
km2$withinss
km2$betweenss
### Set the Work Directory
getwd()
setwd("E:\\Locker\\Sai\\Sai...Nait\\DecBtch\\R_Datasets")
#***
ins<-read.table("clust.csv",head=T,sep=",")
View(ins)
head(ins,10)
ins1<-ins[,c(2,5)]
head(ins1)
km<-kmeans(ins1,4)
plot(ins1$Income,ins1$Age,col=km$cluster)
plot(ins1$Age,ins1$Income,col=km$cluster)#install.packages("animation")
#library(animation)
kmeans.ani(ins1,4)
kmeans.ani(ins1,3)
kmeans.ani(ins1,2)
km<-kmeans(ins1,3)
plot(ins1$Income,ins1$Age,col=km$cluster)
plot(ins1$Age,ins1$Income,col=km$cluster)
km<-kmeans(ins1,2)
plot(ins1$Income,ins1$Age,col=km$cluster)
plot(ins1$Age,ins1$Income,col=km$cluster)
km<-kmeans(ins1,1)
plot(ins1$Income,ins1$Age,col=km$cluster)
plot(ins1$Age,ins1$Income,col=km$cluster)km<-kmeans(ins1,4)
km$cluster
km$centers
km$totss
km$withinss
km$tot.withinss
km$betweenss
km$size
str(km)
km$cluster
ins2<-cbind(ins1,km$cluster)
head(ins2)
plot(ins2$Income,ins2$Age,col=km$cluster)
write.csv(ins2,"Output.csv")
?kmeans
#***#install.packages("xlsx")
library(xlsx)
input <- read.xlsx("Universities_Clustering.xlsx",1)
head(input)
mydata <- input[1:25,c(1,3:8)]
View(mydata)
normalized_data <- scale(mydata[,2:7])
head(normalized_data)
fit <- kmeans(normalized_data,5)
kmeans.ani(normalized_data,7)
str(fit)
View(mydata)
fit$cluster
final2 <- data.frame(mydata,fit$cluster)head(final2)
final3 <- final2[,c(ncol(final2),1:(ncol(final2)-1))]
head(final3,n= 25)
View(final3)
aggregate(mydata[,2:7], by=list(fit$cluster),FUN=mean)
set.seed(12345)
sample(letters)