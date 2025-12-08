#install.packages("arules")
library(arules)
getwd()
setwd("E:\\Locker\\Sai\\SaiHCourseNait\\DecBtch\\R_Datasets")
getwd()
data <- read.csv("groceries_200.csv")
head(data)
#install.packages("arulesViz")
library(arulesViz)
groceries<-
read.transactions("Groceries_200.csv",rm.duplicates=TRUE,format="single",sep=",",cols=c(1,2))
inspect(groceries)
#This takes a lot of time
summary(groceries)
#Plot the dataitemFrequencyPlot(groceries,topN=20,type="absolute")
groceries
itemFrequencyPlot(groceries,topN=10,type="absolute")
itemFrequencyPlot(groceries,topN=10)
?apriori
rules = apriori(groceries, parameter=list(support=0.02, confidence=0.5))
inspect(rules[1:10])
inspect(rules)
summary(rules)
rules = apriori(groceries, parameter=list(minlen=2,maxlen=3,support=0.02, confidence=0.5))
inspect(rules[1:10])
inspect(rules)
rules = apriori(groceries, parameter=list(minlen=3,maxlen=3,support=0.02, confidence=0.5))inspect(rules)
summary(rules)
# This is time consuming
#groceries<-
read.transactions("Groceries_1000.csv",rm.duplicates=TRUE,format="single",sep=",",cols=c(1,2))
#Plot the data
itemFrequencyPlot(groceries,topN=20,type="absolute")
rules = apriori(groceries, parameter=list(support=0.02, confidence=0.5))
inspect(rules[1:5])
rules = apriori(groceries, parameter=list(support=0.02, confidence=0.1))
inspect(rules)
rules = apriori(groceries, parameter=list(support=0.03, confidence=0.5))
#***
#***
#bhrai-jylracdm
library(datasets)
data(Groceries)
head(Groceries)summary(Groceries)
inspect(Groceries[1:10])
rules <- apriori(Groceries)
#inspect(rules[1:5])
rules <- apriori(Groceries, parameter = list(supp=0.001, conf=0.5))
inspect(rules[1:5])
itemFrequencyPlot(Groceries,topN=10,type="absolute")
itemFrequencyPlot(Groceries,topN=10)
itemFrequencyPlot(Groceries,topN=5,type="absolute")
itemFrequencyPlot(Groceries,topN=5)
itemFrequencyPlot(Groceries,topN=20,type="absolute")
itemFrequencyPlot(Groceries,topN=20)
itemFrequencyPlot(Groceries,support=0.1)
itemFrequencyPlot(Groceries,support=0.2)metric.params <- list(supp=0.001, conf=0.5)
rules <- apriori(Groceries, parameter = list(supp=0.001, conf=0.5))
inspect(rules[1:5])
rules <- apriori(Groceries, parameter = list(supp=0.001, conf=0.8))
inspect(rules[1:5])
rules <- sort(rules, by="confidence", decreasing=TRUE)
head(rules)
#rules <- prune.dup.rules(rules)
inspect(rules[1:20])
inspect(rules[1:200])
metric.params <- list(supp=0.001,conf=0.5, minlen=2)
rules<-apriori(data=Groceries, parameter=metric.params,
appearance = list(default="lhs",rhs="soda"),
control = list(verbose=F))
#rules <- prune.dup.rules(rules)
rules<-sort(rules, decreasing=TRUE, by="confidence")
inspect(rules[1:5])metric.params <- list(supp=0.001, conf = 0.3, minlen=2)
rules<-apriori(data=Groceries, parameter=metric.params,
appearance = list(default="rhs",
lhs=c("yogurt", "sugar")),
control=list(verbose=F))
#rules <- prune.dup.rules(rules)
rules<-sort(rules, decreasing=TRUE,by="confidence")
inspect(rules[1:5])
# set better support and confidence levels to learn more rules
groceryrules <- apriori(groceries, parameter = list(support = 0.006, confidence = 0.25,
minlen = 2))
groceryrules
summary(groceryrules)
inspect(groceryrules[1:5])
# finding subsets of rules containing any berry items
berryrules <- subset(groceryrules, items %in% "berries")
inspect(berryrules)
summary(berryrules)
# finding subsets of rules that precede soda purchases
sodarules <- subset(groceryrules, rhs %pin% "soda")inspect(sodarules)
top.soda.rules <- head(sort(sodarules, by = "lift"), 5)
inspect(top.soda.rules)
#***
accident_data <- read.csv("accidents.csv")
str(accident_data)
summary(accident_data)
head(accident_data)
tail(accident_data)
#get column names of the data set
names(accident_data)
colnames <- names(accident_data)
"
#Start building a file in basket format - one row per transaction
and each column value becoming# a basket item in the format <column_name>=<column_value>"
basket_str <- ""
for ( row in 1:nrow(accident_data)) {
if ( row != 1) {
basket_str <- paste0(basket_str, "\n")
}
basket_str <- paste0(basket_str, row,",")
for (col in 2:length(colnames)) {
if ( col != 2) {
basket_str <- paste0(basket_str, ",")
}
basket_str <- paste0(basket_str, colnames[col],"=",accident_data[row,col])
}
}
#basket_str
"
This is like a format of
txnId,item1,item2...
1 is txnId
item1 is Police_Force=1
and so on...
#[1] 1,Police_Force=1,Accident_Severity=3,Number_of_Vehicles=3,Number_of_Casualties=2,Day_of_Week=2,Local_Authority_.District.=1,
Road_Type=3,Speed_limit=30,Junction_Detail=3,
Pedestrian_Crossing.Physical_Facilities=5,Light_Conditions=4,
Weather_Conditions=1,Road_Surface_Conditions=1,Urban_or_Rural_Area=1,
Did_Police_Officer_Attend_Scene_of_Accident=1\n2,Police_Force=1,
Accident_Severity=3,Number_of_Vehicles=1,Number_of_Casualties=1,
Day_of_Week=3,Local_Authority_.District.=2,Road_Type=2,Speed_limit=30,
Junction_Detail=3,Pedestrian_Crossing.Physical_Facilities=5,
Light_Conditions=4,Weather_Conditions=1,Road_Surface_Conditions=1,
Urban_or_Rural_Area=1,Did_Police_Officer_Attend_Scene_of_Accident=1\n3,
Police_Force=1,Accident_Severity=3,Number_of_Vehicles=2,
Number_of_Casualties=1,Day_of_Week=3,Local_Authority_.District.=2,
Road_Type=6,Speed_limit=30,Junction_Detail=8,
Pedestrian_Crossing.Physical_Facilities=0,Light_Conditions=4,
Weather_Conditions=1,Road_Surface_Conditions=1,Urban_or_Rural_Area=1,
Did_... <truncated>
"
getwd()
#This will take a long time so do this once and save it
#write(basket_str,"accidents_basket.csv")
accidents <- read.transactions("accidents_basket.csv",sep=",")summary(accidents)
dev.off()
itemFrequencyPlot(accidents,topN=10,type="absolute",col="darkgreen", horiz=TRUE)
itemFrequencyPlot(accidents,topN=10)
rules <- apriori(accidents, parameter=list(supp=0.1, conf=0.3))
inspect(rules[1:40])
library(arulesViz)
rules2 <- rules[1:50]
plot(rules2)
plot(rules2,method="grouped")
plot(rules2,method="graph")
plot(rules2,method="graph",control=list(type="items"))