setwd("C:\\Users\\...Downloads\\...")
getwd()
# loading libraries
#install.packages("tree")
#install.packages("party")
#install.packages("partykit")
library(tree)
library(party)
#install.packages("rpart")
library(rpart) # Popular decision tree algorithm
#install.packages("rpart.plot")
library(rpart.plot) # Enhanced tree plots
library(party) # Alternative decision tree algorithm
library(partykit)
library(caret)
library(randomForest)
# creating a tree using tree package
setwd("C:\\Users\\...Downloads\\...")
dataSUps <- read.csv("50-Startups.csv")
View(dataSUps)
treeSUps <- tree(Profit ~., data=dataSUps)plot(treeSUps)
text(treeSUps)
cart_model <- rpart(Profit~., data=dataSUps)
plot(as.party(cart_model))
print(cart_model)
summary(cart_model)
rsq.rpart(cart_model)
cart_model <- rpart(Profit~Administration, data=dataSUps)
plot(as.party(cart_model))
rsq.rpart(cart_model)
cart_model <- rpart(Profit~Administration+State, data=dataSUps)
plot(as.party(cart_model))
rsq.rpart(cart_model)
cart_model <- rpart(Profit~R.D.Spend+State, data=dataSUps)
plot(as.party(cart_model))
rsq.rpart(cart_model)
rpart.plot(cart_model)
rpart.plot(cart_model,extra=1)
fit_1<- rpart(Profit~State, method="class",data=dataSUps)
plot(as.party(fit_1))fit_1<- rpart(Profit~State+R.D.Spend, method="class",data=dataSUps)
plot(as.party(fit_1))
rpart.plot(fit_1)
rpart.plot(fit_1,extra=1)
rpart.plot(fit_1,extra=2)
rpart.plot(fit_1,extra=3)
rpart.plot(fit_1,extra=4)
rpart.plot(fit_1,extra=101)
?rpart.plot
treeSUps <- tree(Profit ~Administration, data=dataSUps)
plot(treeSUps)
text(treeSUps)
treeSUps <- tree(Profit ~Administration+Marketing.Spend, data=dataSUps)
plot(treeSUps)
text(treeSUps)
treeSUps <- tree(Profit ~Administration+Marketing.Spend+R.D.Spend, data=dataSUps)
plot(treeSUps)
text(treeSUps)
treeSUps <- tree(Profit ~Administration+Marketing.Spend+R.D.Spend+State, data=dataSUps)
plot(treeSUps)
text(treeSUps)treeSUps
summary(treeSUps)
print(treeSUps$cptable)
#***
DB<-read.csv("Diabetes.csv",head=T)
View(DB)
nrow(DB)
set.seed(2)
DB$ind<-sample(2,nrow(DB),replace=TRUE,prob=c(0.7,0.3))
head(DB$ind)
trainData<-DB[(DB$ind==1),]
View(trainData)
testData<-DB[(DB$ind==2),]
nrow(trainData)
nrow(testData)#library(rpart)
head(trainData)
dt<-rpart(Class.variable~.,
data=trainData,
control=rpart.control(minsplit=10))
dt
plot(dt)
text(dt)
dt<-rpart(Class.variable~.,
data=trainData,
control=rpart.control(minsplit=1))
dt
plot(dt)
text(dt)
str(trainData)
dt<-rpart(Class.variable~Number.of.times.pregnant
+Plasma.glucose.concentration
+Diastolic.blood.pressure
+Triceps.skin.fold.thickness
+X2.Hour.serum.insulin+Body.mass.index
+Diabetes.pedigree.function
+Age..years.,
data=trainData,
control=rpart.control(minsplit=10))
dt
plot(dt)
text(dt)
####Predict####
pred<-predict(dt,testData,type=c("class"))
pred
cbind(as.character(testData$Class.variable),as.character(pred))
#####confusion matrix######
table(as.character(testData$Class.variable),as.character(pred))
127/(127+55)
####Predict-Prob#####
pred1<-predict(dt,testData,type=c("prob"))
pred1
head(pred)
head(pred1)attributes(dt)
dt$variable.importance
#####New Prediction######
New<-read.csv("Diabetes-New.csv",head=T)
View(New)
predict(dt,New,type=c("prob"))
dt<-rpart(Class.variable~Number.of.times.pregnant
+Plasma.glucose.concentration
+Diastolic.blood.pressure
+X2.Hour.serum.insulin,
data=trainData,
control=rpart.control(minsplit=10))
dt
plot(dt)
text(dt)
####Predict####
pred<-predict(dt,testData,type=c("class"))
predcbind(as.character(testData$Class.variable),as.character(pred))
#####confusion matrix######
table(as.character(testData$Class.variable),as.character(pred))
###########RANDOM FOREST###########################
DB<-read.csv("Diabetes.csv",head=T)
head(DB)
View(DB)
nrow(DB)
set.seed(2)
DB$ind<-sample(2,nrow(DB),replace=TRUE,prob=c(0.7,0.3))
head(DB)
trainData<-DB[(DB$ind==1),]
testData<-DB[(DB$ind==2),]
nrow(trainData)
nrow(testData)library(randomForest)
rf<-randomForest(Class.variable~Number.of.times.pregnant
+Plasma.glucose.concentration
+Diastolic.blood.pressure
+Triceps.skin.fold.thickness
+X2.Hour.serum.insulin
+Body.mass.index
+Diabetes.pedigree.function
+Age..years.,
data=trainData,ntree=600,mtry=4)
rf
#293/(293+107)
attributes(rf)
rf$importance
predRF<-predict(rf,testData,type=c("class"))
#####confusion matrix######
table(as.character(testData$Class.variable),as.character(predRF))
138/(138+56)
###################### RF Bank ################
####################NAIVE BAYES##################DB<-read.csv("Diabetes.csv",head=T)
head(DB)
nrow(DB)
set.seed(2)
DB$ind<-sample(2,nrow(DB),replace=TRUE,prob=c(0.7,0.3))
head(DB)
trainData<-DB[(DB$ind==1),]
testData<-DB[(DB$ind==2),]
library(e1071)
NB<-naiveBayes(Class.variable~Number.of.times.pregnant
+Plasma.glucose.concentration
+Diastolic.blood.pressure
+Triceps.skin.fold.thickness
+X2.Hour.serum.insulin
+Body.mass.index
+Diabetes.pedigree.function
+Age..years.,
data=trainData)
attributes(NB)
NB$aprioriNB$tables
predNB<-predict(NB,testData,type=c("class"))
###Confusion Matrix####
table(testData$Class.variable,predNB)
head(trainData)
View(trainData)
trainData1<-trainData[,-10]
head(trainData1)
NB1<-naiveBayes(Class.variable~., data=trainData1)
predNB1<-predict(NB1,testData,type=c("class"))
###Confusion Matrix####
table(testData$Class.variable,predNB1)
##### Naives Bayes Doc Classification ###
#Data Engineering & Analysis
setwd("C:\\Users\\...Downloads\\...")
getwd()
sms_data <- read.csv("sms_spam_short.csv", stringsAsFactors=FALSE)View(sms_data)
sms_data$type <- as.factor(sms_data$type)
str(sms_data)
summary(sms_data)
#Data Cleansing
#The dataset contains raw text.
#The text need to be pre-processed and converted into a
#Document Term Matrix before it can be used for
#classification purposes.
library(tm)
## Loading required package: NLP
#create a corpus for the message
mesg_corpus <- Corpus(VectorSource(sms_data$text))
#peek into the corpus
inspect(mesg_corpus[1:5])
#cleanse the data
#remove punctuation marks
refined_corpus <- tm_map(mesg_corpus, removePunctuation)#remove white space
refined_corpus <- tm_map(refined_corpus, stripWhitespace)
#convert to lower case
#refined_corpus <- tm_map(refined_corpus, content_transformer(tolower))
#remove numbers in text
refined_corpus <- tm_map(refined_corpus, removeNumbers)
#remove stop words
refined_corpus <- tm_map(refined_corpus, removeWords, stopwords())
#remove specific words
refined_corpus <- tm_map(refined_corpus, removeWords, c("else","the","are","for",
"has","they","as","a","his","on","when","is","in","already"))
#look at the processed text
inspect(refined_corpus[1:5])
#create a document-term sparse matrix
dtm <- DocumentTermMatrix(refined_corpus)
dtm
dim(dtm)
#Remove all words who has occured less than 10 times to create a new DTM
filtered_dtm <- DocumentTermMatrix(refined_corpus, list(dictionary=findFreqTerms(dtm, 10)))
dim(filtered_dtm)
#inspect the contents be converting it into a matrix and transposing it
t(inspect(filtered_dtm)[1:25,1:10])#Exploratory Data Analysis
#The following example shows a word cloud for both ham and spam message.
#The size of words shown in the word cloud is based on the frequency of occurance. It will clearly
show that
#there is a difference in the most common occuring words between these types
library(wordcloud)
pal <- brewer.pal(9,"Dark2")
wordcloud(refined_corpus[sms_data$type=="ham"], min.freq=5,
random.order=FALSE, colors=pal)
wordcloud(refined_corpus[sms_data$type=="spam"], min.freq=2,
random.order=FALSE, colors=pal)
#Modeling & Prediction
#Split Training and Testing
#Split training and testing datasets in the ratio of 70-30
library(caret)
inTrain <- createDataPartition(y=sms_data$type ,p=0.7,list=FALSE)
#Spliting the raw data
train_raw <- sms_data[inTrain,]
test_raw <- sms_data[-inTrain,]
#spliting the corpustrain_corpus <- refined_corpus[inTrain]
test_corpus <- refined_corpus[-inTrain]
#spliting the dtm
train_dtm <- filtered_dtm[inTrain,]
test_dtm <-filtered_dtm[-inTrain,]
# Instead of using the counts of words within document,
# we will replace them with indicators "Yes" or "No".
# Yes indicates if the word occured in the document and No indicate it does not. This procedure
converts
# Numeric data into factor data
conv_counts <- function(x) {
x <- ifelse(x > 0, 1, 0)
x <- factor(x, levels = c(0, 1), labels = c("No", "Yes"))
}
train <- apply(train_dtm, MARGIN = 2, conv_counts)
test <- apply(test_dtm, MARGIN = 2, conv_counts)
#convert to a data frame and add the target variable
df_train <- as.data.frame(train)
df_test <- as.data.frame(test)
df_train$type <- train_raw$type
df_test$type <- test_raw$type
df_train[1:10,1:10]
#Model Building
#Build model based on the training data
library(e1071)#Leave out the last column (target)
#modFit <- naiveBayes(df_train[,-60], df_train$type)
modFit <- naiveBayes(df_train[,-66], df_train$type)
modFit
View(df_train)
##Testing
##Now let us predict the class for each sample in the test data.
##Then compare the prediction with the actual value of the class.
predictions <- predict(modFit, df_test)
confusionMatrix(predictions, df_test$type)