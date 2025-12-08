#**********************MODEL PERFORMANCE
ASSESSMENT************************************
#***
setwd("E:\\Locker\\Sai\\SaiHCourseNait\\DecBtch\\R_Datasets")
FullData <- read.csv ('Log-Reg-Case-Study.csv')
set.seed(123)
train = sample(1:nrow(FullData),nrow(FullData)*.7)
test = -train
ModelData = FullData[train,]
ValidationData = FullData[test,]
ModelData$Age<-ifelse(ModelData$Age >75, 75, ModelData$Age)
ModelData$Housing[ModelData$Housing ==""] <- "A152"
ModelData$Job_Status[ModelData$Job_Status ==""] <- "A174"
#Dummy Variables for Job_Status
ModelData$Dummy_Job_Status_A171<-ifelse(ModelData$Job_Status =="A171", 1,0)
ModelData$Dummy_Job_Status_A172<-ifelse(ModelData$Job_Status =="A172", 1,0)
ModelData$Dummy_Job_Status_A173<-ifelse(ModelData$Job_Status =="A173", 1,0)
#Dummy Variables for Purpose_Credit_Taken
ModelData$Dummy_Purpose_Credit_Taken_Low <-
ifelse (ModelData$Purpose_Credit_Taken == "P41" |
ModelData$Purpose_Credit_Taken == "P43" |
ModelData$Purpose_Credit_Taken == "P48",1,0)
ModelData$Dummy_Purpose_Credit_Taken_High <-ifelse (ModelData$Purpose_Credit_Taken == "P49" |
ModelData$Purpose_Credit_Taken == "P40" |
ModelData$Purpose_Credit_Taken == "P45" |
ModelData$Purpose_Credit_Taken == "P50" |
ModelData$Purpose_Credit_Taken == "P46", 1, 0)
#Dummy Variables for Status_Checking_Accnt
ModelData$Dummy_Status_Checking_Accnt_High<-
ifelse(ModelData$Status_Checking_Accnt =="S11", 1,0)
ModelData$Dummy_Status_Checking_Accnt_Medium<-
ifelse(ModelData$Status_Checking_Accnt =="S12", 1,0)
#Dummy Variables for Credit_History
ModelData$Dummy_Credit_History_High <-
ifelse (ModelData$Credit_History == "A30" |
ModelData$Credit_History == "A31", 1, 0)
ModelData$Dummy_Credit_History_Low <-
ifelse(ModelData$Credit_History =="A34", 1,0)
#Dummy Variables for Years_At_Present_Employment
ModelData$Dummy_Years_At_Present_Employment_High <-
ifelse (ModelData$Years_At_Present_Employment == "E71" |
ModelData$Years_At_Present_Employment == "E72", 1, 0)ModelData$Dummy_Years_At_Present_Employment_Medium <-
ifelse(ModelData$Years_At_Present_Employment =="E73", 1,0)
#Dummy Variables for Marital_Status_Gender
ModelData$Dummy_Marital_Status_Gender <-
ifelse (ModelData$Marital_Status_Gender == "A91" |
ModelData$Marital_Status_Gender == "A92" , 1, 0)
#Dummy Variable for Other_Debtors_Guarantors
ModelData$Dummy_Other_Debtors_Guarantors <-
ifelse(ModelData$Other_Debtors_Guarantors =="A103", 0,1)
#Dummy variable for Housing
ModelData$Dummy_Housing <-
ifelse(ModelData$Housing =="A152", 0,1)
#Dummy variable for Foreign_Worker
ModelData$Dummy_Foreign_Worker <-
ifelse(ModelData$Foreign_Worker =="A201", 1,0)
ModelData$Dummy_Age_Group<-
ifelse(ModelData$Age < 30, 1,0)
#Dummy variable for Credit_Amount
ModelData$Dummy_Credit_Amount <-ifelse(ModelData$Credit_Amount < 5000, 0, 1)
#Dummy variable for Current_Address_Yrs
ModelData$Dummy_Current_Address_Yrs <-
ifelse(ModelData$Current_Address_Yrs == 1, 0, 1)
#install.packages("car")
library(car) #R package for Multicollinearity Analysis
vif_output <- lm(Default_On_Payment ~ Dummy_Job_Status_A171 + Dummy_Job_Status_A172 +
Dummy_Job_Status_A173 + Dummy_Purpose_Credit_Taken_High +
Dummy_Purpose_Credit_Taken_Low +
Dummy_Status_Checking_Accnt_High + Dummy_Status_Checking_Accnt_Medium +
Dummy_Credit_History_High + Dummy_Credit_History_Low +
Dummy_Years_At_Present_Employment_High +
Dummy_Years_At_Present_Employment_Medium +
Dummy_Marital_Status_Gender + Dummy_Other_Debtors_Guarantors + Dummy_Housing +
Dummy_Foreign_Worker + Dummy_Age_Group + Dummy_Credit_Amount +
Dummy_Current_Address_Yrs + Duration_in_Months, data = ModelData)
# View vif output
vif(vif_output)
# Regress both variables separately and retain the one with higher R-square
Multicoll_out1 <- lm(Default_On_Payment ~ Dummy_Job_Status_A172,
data = ModelData)
Multicoll_out2 <- lm(Default_On_Payment ~ Dummy_Job_Status_A173,
data = ModelData)# Remove Dummy_Job_Status_A173 & repeat VIF
vif_output <- lm(Default_On_Payment ~ Dummy_Job_Status_A171
+ Dummy_Job_Status_A172 + Dummy_Purpose_Credit_Taken_High
+ Dummy_Purpose_Credit_Taken_Low + Dummy_Status_Checking_Accnt_High
+ Dummy_Status_Checking_Accnt_Medium + Dummy_Credit_History_High
+ Dummy_Credit_History_Low + Dummy_Years_At_Present_Employment_High
+ Dummy_Years_At_Present_Employment_Medium + Dummy_Marital_Status_Gender
+ Dummy_Other_Debtors_Guarantors + Dummy_Housing
+ Dummy_Foreign_Worker + Dummy_Age_Group + Dummy_Credit_Amount
+ Dummy_Current_Address_Yrs + Duration_in_Months,
data = ModelData)
vif(vif_output)
# Dummy_Purpose_Credit_Taken_High & Dummy_Purpose_Credit_Taken_Low have VIF > 1.5
# Regress both variables separately and retain the one with higher R-square
Multicoll_out3 <- lm(Default_On_Payment
~ Dummy_Purpose_Credit_Taken_High,
data = ModelData)
Multicoll_out4 <- lm(Default_On_Payment
~ Dummy_Purpose_Credit_Taken_Low,
data = ModelData)
vif_output <- lm(Default_On_Payment ~ Dummy_Job_Status_A171+ Dummy_Job_Status_A172 + Dummy_Purpose_Credit_Taken_Low
+ Dummy_Status_Checking_Accnt_High + Dummy_Status_Checking_Accnt_Medium
+ Dummy_Credit_History_High + Dummy_Credit_History_Low
+ Dummy_Years_At_Present_Employment_High +
Dummy_Years_At_Present_Employment_Medium
+ Dummy_Marital_Status_Gender + Dummy_Other_Debtors_Guarantors
+ Dummy_Housing + Dummy_Foreign_Worker
+ Dummy_Age_Group + Dummy_Credit_Amount
+ Dummy_Current_Address_Yrs + Duration_in_Months,
data = ModelData)
vif(vif_output)
# All VIF values < 1.5, hence good to proceed to the next step
LogReg_Output <- glm(Default_On_Payment ~ Dummy_Job_Status_A171
+ Dummy_Job_Status_A172
+ Dummy_Purpose_Credit_Taken_Low
+ Dummy_Status_Checking_Accnt_High
+ Dummy_Status_Checking_Accnt_Medium
+ Dummy_Credit_History_High
+ Dummy_Credit_History_Low
+ Dummy_Years_At_Present_Employment_High
+ Dummy_Years_At_Present_Employment_Medium
+ Dummy_Marital_Status_Gender
+ Dummy_Other_Debtors_Guarantors
+ Dummy_Housing
+ Dummy_Foreign_Worker+ Dummy_Age_Group
+ Dummy_Credit_Amount
+ Dummy_Current_Address_Yrs
+ Duration_in_Months,
family=binomial (logit), data= ModelData)
# Remove insignificant variables
LogReg_Output <- glm(Default_On_Payment ~ Dummy_Purpose_Credit_Taken_Low
+ Dummy_Status_Checking_Accnt_High
+ Dummy_Status_Checking_Accnt_Medium
+ Dummy_Credit_History_High
+ Dummy_Credit_History_Low
+ Dummy_Years_At_Present_Employment_High
+ Dummy_Housing
+ Dummy_Marital_Status_Gender
+ Dummy_Other_Debtors_Guarantors
+ Dummy_Foreign_Worker
+ Dummy_Current_Address_Yrs
+ Duration_in_Months,
family=binomial (logit), data= ModelData)
# View revised model output
summary(LogReg_Output, direction="forward")
ModelData$Predicted_Probability <-
predict(LogReg_Output, ModelData, type="response") # calculate predicted values
### Step 5 - Logistic Regression - Model Validation# Outlier Capping
# If condition to change all Age values above 75 as 75
ValidationData$Age<-
ifelse(ValidationData$Age >75, 75, ValidationData$Age)
# Missing Value Imputation
# If condition to fill the missing values in Housing
ValidationData$Housing[ValidationData$Housing ==""] <- "A152"
# Missing Value Imputation
ValidationData$Job_Status[ValidationData$Job_Status ==""] <- "A174"
#Dummy for Job_Status
ValidationData$Dummy_Job_Status_A171<-
ifelse(ValidationData$Job_Status =="A171", 1,0)
ValidationData$Dummy_Job_Status_A172<-
ifelse(ValidationData$Job_Status =="A172", 1,0)
ValidationData$Dummy_Job_Status_A173<-
ifelse(ValidationData$Job_Status =="A173", 1,0)
#Dummy Variables for Purpose_Credit_Taken
ValidationData$Dummy_Purpose_Credit_Taken_Low <-
ifelse (ValidationData$Purpose_Credit_Taken == "P41"| ValidationData$Purpose_Credit_Taken == "P43"
| ValidationData$Purpose_Credit_Taken == "P48",1,0)
ValidationData$Dummy_Purpose_Credit_Taken_High <-
ifelse (ValidationData$Purpose_Credit_Taken == "P49"
| ValidationData$Purpose_Credit_Taken == "P40"
| ValidationData$Purpose_Credit_Taken == "P45"
| ValidationData$Purpose_Credit_Taken == "P50"
| ValidationData$Purpose_Credit_Taken == "P46", 1, 0)
#Dummy Variables for Status_Checking_Accnt
ValidationData$Dummy_Status_Checking_Accnt_High<-
ifelse(ValidationData$Status_Checking_Accnt =="S11", 1,0)
ValidationData$Dummy_Status_Checking_Accnt_Medium<-
ifelse(ValidationData$Status_Checking_Accnt =="S12", 1,0)
#Dummy Variables for Credit_History
ValidationData$Dummy_Credit_History_High <-
ifelse (ValidationData$Credit_History == "A30"
| ValidationData$Credit_History == "A31", 1, 0)
ValidationData$Dummy_Credit_History_Low <-
ifelse(ValidationData$Credit_History =="A34", 1,0)#Dummy Variables for Years_At_Present_Employment
ValidationData$Dummy_Years_At_Present_Employment_High <-
ifelse (ValidationData$Years_At_Present_Employment == "E71"
| ValidationData$Years_At_Present_Employment == "E72", 1, 0)
ValidationData$Dummy_Years_At_Present_Employment_Medium <-
ifelse(ValidationData$Years_At_Present_Employment =="E73", 1,0)
#Dummy Variables for Marital_Status_Gender
ValidationData$Dummy_Marital_Status_Gender <-
ifelse (ValidationData$Marital_Status_Gender == "A91"
| ValidationData$Marital_Status_Gender == "A92" , 1, 0)
#Dummy Variable for Other_Debtors_Guarantors
ValidationData$Dummy_Other_Debtors_Guarantors <-
ifelse(ValidationData$Other_Debtors_Guarantors =="A103", 0,1)
#Dummy variable for Housing
ValidationData$Dummy_Housing <-
ifelse(ValidationData$Housing =="A152", 0,1)
#Dummy variable for Foreign_Worker
ValidationData$Dummy_Foreign_Worker <-
ifelse(ValidationData$Foreign_Worker =="A201", 1,0)#Dummy variable for Age
ValidationData$Dummy_Age_Group<-
ifelse(ValidationData$Age < 30, 1,0)
#Dummy variable for Credit_Amount
ValidationData$Dummy_Credit_Amount <-
ifelse(ValidationData$Credit_Amount < 5000, 0, 1)
#Dummy variable for Current_Address_Yrs
ValidationData$Dummy_Current_Address_Yrs <-
ifelse(ValidationData$Current_Address_Yrs == 1, 0, 1)
#Multicollinearity Check
vif_output <- lm(Default_On_Payment ~ Dummy_Purpose_Credit_Taken_Low +
Dummy_Status_Checking_Accnt_High + Dummy_Status_Checking_Accnt_Medium +
Dummy_Credit_History_High + Dummy_Credit_History_Low +
Dummy_Years_At_Present_Employment_High + Dummy_Housing +
Dummy_Marital_Status_Gender + Dummy_Other_Debtors_Guarantors +
Dummy_Foreign_Worker + Dummy_Current_Address_Yrs + Duration_in_Months,
data = ValidationData)
vif(vif_output)# Estimate the probability of each record
# Note that we are using LogReg_Output to estimate the probability of default
ValidationData$Predicted_Probability <-
predict(LogReg_Output, ValidationData, type="response") # calculate predicted values
#***
# Create the final flag - Prediction, based on Probability for Model & Validation datasets
ModelData$Final_Prediction <-
ifelse(ModelData$Predicted_Probability > 0.3, 1,0)
ValidationData$Final_Prediction <-
ifelse(ValidationData$Predicted_Probability > 0.3,1,0)
#*** roc braib
library(ROCR)
pred <- predict(LogReg_Output,ValidationData,type="response")
head(pred)
hist(pred)
head(cbind(ValidationData$Default_On_Payment,pred))pred <- prediction(pred,ValidationData$Default_On_Payment)
eval <- performance(pred,"acc")
plot(eval)
plot(eval)
abline(h=0.78)
plot(eval)
abline(h=0.76)
plot(eval)
abline(h=0.76,v=0.51) # this is manual way of finding acc
eval
max <- which.max(slot(eval,"y.values")[[1]])
max
acc <- slot(eval,"y.values")[[1]][max]
acc
cutoff <- slot(eval,"x.values")[[1]][max]
cutoffprint(c(Accuracy=acc,Cutoff=cutoff))
# cutoff 0.48 gvs us the best acc
# this is based on the conf mtrx tht v hv seen
# this is calld overall acc
# but smtimes v may not b interested in overall acc
# v r more concerned abt predicting more accurately in 1 group
# ie all 1s instead of 0s
# ie v r more concerned abt more def on pymnts
# so v u roc curve
pred <- prediction(pred,ValidationData$Default_On_Payment)
performance(pred,"tpr")
table(ValidationData$Default_On_Payment, ValidationData$Final_Prediction)
332/(327+332)
#50%
roc <- performance(pred,"tpr","fpr")
# this is based on the default cutoff val of 50%
# roc curve gvs the perf for dffrnt cutoff vals
109/(109+732)
#12%
plot(roc)
abline(a=0,b=1) #intercept is 0 & slope is 1
# the curve is above this line# so it is better
# if it is below the line
# then it is not doing well
# v can calc this curve for mult models
# and select the best model
plot(roc,colorize=T)
# the color is based on the cutoff
# cutoff vals range from 0.01 to 0.91
plot(roc,colorize=T,main="ROC Curve",ylab="Sensitivity",xlab="1-Specificity")
abline(a=0,b=1)
# AUC
# when there are mult curves v cannot dfrntiate the curves
# so auc gvs a numeric val
auc <- performance(pred,"auc")
auc <- unlist(slot(auc,"y.values"))
auc <- round(auc,2)
legend(.6,.2,auc,title="AUC",cex=1.2)
# Churn Anlss