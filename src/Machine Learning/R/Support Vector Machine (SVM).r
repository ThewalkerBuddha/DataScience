dataX <- runif(20,min=0,max=10)
dataY <- runif(20,min=0,max=10)
plot(dataY,dataX)
plot(dataX,dataY)
class <- rep("A",20)
class
class[dataX>5] <- "B"
class
plot(dataX,dataY)
plot(dataX,dataY,col=ifelse(class=="A","red","blue"))
plot(dataX,dataY,col=ifelse(class=="A","red","blue"),pch=16)
library(e1071)
data <- data.frame(dataX,dataY,class)
data#v want to make prediction for class with the
#help of dataX & dataY
"
this is a linearly separable
cost is 0.1
this is a number that specifies the cost
for violating the constraints
Remem the goal of svm is to separate the margin as wide as
possible
so how big is the penalty for the margin
so if the cost is large the margin will be very narrow
"
model <- svm(class~.,data,kernel="linear",cost=0.1)
model
plot(model,data=data)
predict(model,data.frame(dataX=1,dataY=1))
predict(model,data.frame(dataX=5,dataY=8))
set.seed(1)tunedModel <- tune(svm,class~.,data=data,kernel="linear",ranges=list(cost=c(0.001,0.01,0.1,1,10,100)))
bestModel <- tunedModel$best.model
bestModel
predict(bestModel,data.frame(dataX=2,dataY=2))
#radial kernel
dataX <- runif(40,min=0,max=10)
dataY <- runif(40,min=0,max=10)
plot(dataX,dataY)
class <- rep("A",40)
class
class[dataX>2.5 & data<4.5] <- "B"
class
plot(dataX,dataY,col=ifelse(class=="A","red","blue"),pch=16)
data <- data.frame(dataX,dataY,class)
data#gamma will tell the width of the distribution
model <- svm(class~.,data,kernel="radial",gamma=1,cost=0.1)
model
" With the help of tuning we will be able to
calc the best pars for gamma & cost"
plot(model,data=data)
model <- svm(class~.,data,kernel="radial",gamma=1,cost=1)
plot(model,data=data)
model <- svm(class~.,data,kernel="radial",gamma=10,cost=1)
plot(model,data=data)
model <- svm(class~.,data,kernel="radial",gamma=1,cost=1)
plot(model,data=data)
"So this is where tuning comes into picture
v cannot know all the parameters of gamma & cost"
tunedModel <- tune(svm,class~.,data=data,kernel="radial",
ranges=list(cost=c(0.1,0.01,1,10),
gamma=c(0.01,0.1,1,10)))predict(model,data.frame(dataX=1,dataY=1))
predict(model,data.frame(dataX=5,dataY=8))
"
max(data$dataX)
filter = data$dataX==max(data$dataX)
data[filter,]
which(filter)
set.seed(1)
tunedModel <- tune(svm,class~.,data=data,kernel="linear",ranges=list(cost=c(0.001,0.01,0.1,1,10,100)))
bestModel <- tunedModel$best.model
bestModel
predict(bestModel,data.frame(dataX=2,dataY=2))
"
#***
getwd()
setwd("E:\\...\\R_Datasets")
loans <- read.csv('loan_data.csv')str(loans)
summary(loans)
loans$credit.policy <- factor(loans$credit.policy)
loans$inq.last.6mths <- factor(loans$inq.last.6mths)
loans$delinq.2yrs <- factor(loans$delinq.2yrs)
loans$pub.rec <- factor(loans$pub.rec)
loans$not.fully.paid <- factor(loans$not.fully.paid)
summary(loans)
library(ggplot2)
pl <- ggplot(loans,aes(x=fico))
pl <- pl + geom_histogram(aes(fill=not.fully.paid),color='black',bins=40,alpha=0.5)
pl + scale_fill_manual(values = c('green','red')) + theme_bw()pl <- ggplot(loans,aes(x=factor(purpose)))
pl <- pl + geom_bar(aes(fill=not.fully.paid),position = "dodge")
pl + theme_bw() + theme(axis.text.x = element_text(angle = 90, hjust = 1))
ggplot(loans,aes(int.rate,fico)) +geom_point() + theme_bw()
ggplot(loans,aes(int.rate,fico)) +geom_point(aes(color=not.fully.paid),alpha=0.3) + theme_bw()
library(caTools)
set.seed(101)
spl = sample.split(loans$not.fully.paid, 0.7)
train = subset(loans, spl == TRUE)
test = subset(loans, spl == FALSE)
library(e1071)
model <- svm(not.fully.paid ~ .,data=train)
#This will take some good time
summary(model)
#plot(model)predicted.values <- predict(model,test[1:13])
table(predicted.values,test$not.fully.paid)
#This will also take v v long time so b aware of it
#as it is computationally heavy
tune.results <- tune(svm,train.x=not.fully.paid~., data=train,kernel='radial',
ranges=list(cost=c(1,10), gamma=c(0.1,1)))
summary(tune.results)
"
predicted.values 0 1
0 2413 460
1 0 0
"
model <- svm(not.fully.paid ~ .,data=train,cost=1,gamma = 0.1)
predicted.values <- predict(model,test[1:13])
table(predicted.values,test$not.fully.paid)
"
predicted.values 0 1
0 2350 425
1 63 35
"