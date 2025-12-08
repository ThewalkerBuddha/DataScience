AirPassengers
class(AirPassengers)
start(AirPassengers)
end(AirPassengers)
frequency(AirPassengers)
#The cycle of ts is 12 months in a year
summary(AirPassengers)
plot(AirPassengers)
abline(reg=lm(AirPassengers~time(AirPassengers)))
# fit a line
cycle(AirPassengers)
# print the cycle across years
plot(aggregate(AirPassengers,FUN=mean))
# This will agg the cycle and display a yr or yr trend
# or general trend
data <- ChickWeighthead(data)
#dimension of the data
dim(data)
summary(data)
#how many chickens
unique(data$Chick)
#how many diets
unique(data$Diet)
#how many time points
unique(data$Time)
library(ggplot2)
ggplot(data=data, aes(x=Time, y=weight, group=Chick, colour=Chick)) +
geom_line() +
geom_point()
#find the mean weight depending on diet
aggregate(data$weight, list(diet = data$Diet), mean)#aggregate on time
aggregate(data$weight, list(time=data$Time), mean)
#use a different function
aggregate(data$weight, list(time=data$Time), sd)
#we could also aggregate on time and diet
head(aggregate(data$weight,
list(time = data$Time, diet = data$Diet),
mean
),50
)
tail(aggregate(data$weight,
list(time = data$Time, diet = data$Diet),
mean
) )
boxplot(AirPassengers~cycle(AirPassengers))
# gvs a seasonal effect across months
# looks like in the mnths of Jul & Aug
plot(AirPassengers)# ntc this is not statnry
# mean & var r incr
# v need to mk it stat
# v can use
plot(log(AirPassengers))
# ntc the var seems to be same but not the mean
plot(diff(log(AirPassengers)))
# ntc the mean wld b cnstnt and the var also
options(install.packages.check.source = "no")
#install.packages('tseries')
library(tseries)
adf.test(diff(log(AirPassengers)),
alternative = c("stationary","explosive"),k=0)
acf(AirPassengers)
# here the data is not stat
# ntc the lines r abv the blue line
# our obj is 2 keep the lines within the blue line
# We see that the series is not stationary enough to do any kind of
# time series modelling.
acf(log(AirPassengers))# Clearly, the decay of ACF chart is very slow,
# which means that the population is not stationary.
plot(diff(log(AirPassengers)))
a <- diff(log(AirPassengers))
acf(diff(log(AirPassengers)))
acf(a)
plot(a)
# with acf v calc the val of q
# it is the coeff of MA
# ntc the lag2 is getting inverted
# v tk the one b4 tht
# so v tk the lag1 as q
pacf(diff(log(AirPassengers)))
# here v tk p as 0
# and since v applied diff only once d = 1
plot(diff(log(AirPassengers)))
acf(diff(log(AirPassengers)))
# ACF plot cuts off after the first lag.# Hence, the value of p should be 0
# as the ACF
# is the curve getting a cut off.
# While value of q should be 1 or 2. After a few iterations,
# we found that (0,1,1) as (p,d,q) comes out to be the combination
# with least AIC and BIC.
fit <- arima(log(AirPassengers), c(0, 1, 1),seasonal = list(order = c(0, 1, 1), period = 12))
# ntc v r not specifying diff abv
# as v r manually specifying the val of d as 1
pred <- predict(fit, n.ahead = 10*12)
# predict for next 10 yrs
# since v hv used log our vals r in logarithmic form
# v need to convert em to decimal form
# v need to use e value which is 2.718
pred1 <- 2.718^pred$pred
pred1
ts.plot(AirPassengers,2.718^pred$pred, log = "y", lty = c(1,3))
# ntc the dotted lines r predicted lines
# so this is how our future looks like
# Test the modeldatawide <- ts(AirPassengers,frequency = 12, start=c(1949,1),end=c(1959,12))
fit <- arima(log(datawide),seasonal=list(order=c(0,1,1),period=12))
pred <- predict(fit,n.ahead=10*12)
pred1 <- 2.718^pred$pred
data1<-pred1
predicted_1960 <- round(data1,digits=0)
predicted_1960
original_1960 <- tail(AirPassengers,12)
original_1960
#ts.plot(AirPassengers,2.718^pred$pred, log = "y", lty = c(1,3))
#***
getwd()
setwd("E:\\Locker\\Sai\\SaiHCourseNait\\DecBtch\\R_Datasets")
df = read.csv("monthly_sales.csv",sep='')
head(df)
df
df = read.csv("monthly_sales.csv",sep=',')
dim(df)
head(df)str(df)
#Convert to Quarterly data
ts(df$Monthly_sales,frequency = 4,start=c(2017,1))
#Convert to Yearly data
ts(df$Monthly_sales,frequency = 1,start=c(2017,1))
#Convert to half yearly data
ts(df$Monthly_sales,frequency = 2,start=c(2017,1))
#Convert to Monthly data
ts(df$Monthly_sales,frequency = 12,start=c(2017,1))
#lets change the start date so it is more realistic
data = ts(df$Monthly_sales,frequency = 12,start=c(2012,1))
data
plot(data)
df = read.csv("monthly_sales_asDate.csv",sep='')
head(df)str(df)
new_date <- as.Date(df$Month)
new_date
format(new_date,format="%B %d %Y")
# %d - day as number 1-31
# %a - weekday such as Mon
# %A- complete day name ex.Monday
# %m - month as a number
# %b - short form of month Jan, Feb
# %B - full form of month, January
# %y - two digit year
# %Y- four digit year
df = read.csv("monthly_sales.csv",sep=',')
head(df)
str(df)
data = ts(df$Monthly_sales,frequency = 12,start=c(2012,1))
data
plot(data)
plot(data,main="Monthly_sales_of_product")# Additive Time Series
# Trend + Seasonality+ Cyclicity+ error
# Multiplicative Time Series
## Trend * Seasonality * Cyclicity * error
log(data)
#First step
# Identify the stationarity of a time series
# 1- mean value of the time series is constant over time,
# the trend should not be present in the series
# 2- the variance does not increase over time
# 3- the seasonality impact is minimal,
# deseasonalization of the time series data
decompose(data) # default method is additive
#This breaks the ts data into diff components
"
$x is the actual data
$seasonal contains the seasonality index
ntc each month will hv the same vals over all the years
which means they hv the same SI
SI is calc based on auto regressive terms
and moving avg terms$trend is calculated
$random is the irr comp or the error
$type is additive which is the default
"
plot(decompose(data))
decompose(data, type='multi')
plot(decompose(data, type='multi'))
"
ntc the trend & the rand comps
the first few vals do not show anything
"
par(mfrow=c(2,1))
plot(decompose(data, type='multi'))
plot(decompose(data))
"ntc only the tredn comp changes
and others remain the same"
data
par(mfrow=c(1,1))
plot(data)stl(data,s.window = 'period')
#this gvs the decomposed vals
"why shld v try to look & und these comps
so v can build a better predictive model
to generate forecast v need to und which comp is adding
how mch ie to wht extent it is associated or contrubuting
from a linear reg persp v hv only 1 clmn or varbl of data
but v r breaking into mult comps
from lin reg persp v can now treat the other comps as other vars + err
v can hv coeffs for each of th vars + err
seasonal decomposition means
to und the fluctuation behavior and
to und the time srs bhvr and
to und the model cmpnts
so v r breaking em"
#install.packages("forecast")
library(forecast)
seasonplot(data)
#this shows the seasons/yrs
# ea S has specific val and is diff val
data
lag(data,10)#lag is when the base is shifted by given num of events
# mostly used as exploratory vars to explain the model the acttual time srs
# the reason is that
# the state of ts few periods back
# may still hv an influnc on the current state
# for ex u may get few custs tdy
# v dont get all the custs rt tdy only
# sm may look at an ad later and cm to us
# and sm may plan later in the weekends
# this means the ad has an impact tdy tmrw and later also
# sm may decide to buy our prds dur the end of month also
# so the influence of 1 evnt may last mult times in the cmng days
# on the dep var
# lag is an exploratory var
# lead means advance
# why lag
# ea val in the crnt period may b correlated to each
# or mult vals in the prev period
# to what extent v dont know
# but all v know is to sm extent they hv impact
# and how do v know how much is the extent of impct or prev val
# on the crnt val
# 1 way is to create a lin reg model# and und the coeffs
# v can tk the curnt val is y or Yt
# and prev vals as x1...xn or Yt-1, Yt-2...Yt-n vars
# v can use these and und how the prev vals r impacting the curnt val
# for this v try to und the Seasanlity & trend & err
# Yt-1 is lag1 or lagof1 and so on...
# If v hv monthly data v can tk 12 lags
# if v hv daily data v can tk 12 or more or less also
# and und the correlations first
# thts called auto corr
# corr btw lag terms
#ntc even though the data starts with Jan 2012
data
lag(data)
#the default shows lag is 1 month
lag(data,3)
# this creates a 3 period lag
# after taking lags v need to und how the 12th lag or nth lag is impacting
# the crnt val
# this is where v can delete the first 12 rows & the last few rows with NAs# next step is to find the corrs of lags with the crnt period
# this is where v can use lin reg
# in other words v can calc the coeffs using lin reg
# these r called auto reg terms
# this is where acf comes in
lag.plot(data)
#this is not v ez to interpret so v use acf
# Calculation of Autocorrelation and Partial Autocorrelation
data
ac<-acf(data)
ac
ac$acf
# ntc the first val has 1
# frm the 2nd one the corr is dropping and increasing
# if v look at the visual
# auto corr is the corr of ts with its lags
# acf is used to und if the ts is stationary or not
# a statnry ts will hv the auto corr fall to 0 v quickly
# but for a non stat ts it drops gradually or may not drop at all
# so in this v can say this ds not hv stationarity# data time series may not have stationarity
pac<-pacf(data)
# pacf is same as acf
# which is its corr of crnt val with its prev vals
# but the linear dependency is removed
pac$acf
ac<-acf(data)
# look at the visual and ntc the strtng frm a 0 indx
# lag2 (0.50) and lag6 (0.49) hv same corr
# means they hv linear dependency
# in pacf this linear dep is removed
pac<-pacf(data)
# if v look at the pacf graph
# it decreases to 0 in the 2nd lag and increases again
# the in inc then dec again
# in other words there is contiouns shift and drop
# so the statnrty is not achieved here
# in a statnrty graph there is no trend
# so if v wld like to use it for forecasting v need to detrend it first
# looking at the ACF and PACF graph
# we can conclude that the time series is not stationary# so what do v do
# v need to detrend the ts
# how do v do this
# the ts becomes the target var
# and the len of the ts as the indep features
# and then predict using a lin reg model
# frm the model v can pull the model residuals from the trend comp
# and if sm tredn is left over in the residuals
# then v can add few predictors
# using the seasonal dummy comp
# or sm other kind of transformation
# which may be reqd to do the stat in the ts comp
# so what ds that mean
# for this lets tk the raw model
c(1:length(data))
model <- lm(data~c(1:length(data)))
# ntc data is the tar var and len is the indp var
summary(model)
# ntc Adj r sq is 23%
# means only 23% of variation is explained by the lag concepts
# means the detrending is not happening properly
# to represent this graphically
plot(resid(model),type='l')
# this creates a line graph
# this is nothing but the error term or random comp v hv seen earlier# this means using lin reg model v will not b able to detrend this
# so v need to look at other transformations
# v can tk a log transf or exponential smoothing or other methods
# so the series is not stationary
# so next v need to
# deseasonalize the time series
#stl(data,'periodic')
tbl <- stl(data,'periodic')
# deseasonalize will smoothen out the fluctuation jerks
# next do seasonal adjustment
seasadj(tbl)
data
#ntc 742 - 675.1636 = 66.83...
#this dffrnc is nothing but dfrn btw actual val
# and seasonally adjusted ts val
stl(data,s.window="period")
"Call:
stl(x = data, s.window = period)
Components
seasonal trend remainder
Jan 2012 66.836426 791.4140 -116.250394"
# when v do seasonal adj it removes the seasonal adj terms/valsstab<-seasadj(tbl)
seasonplot(stab,12)
# this is not adjusting
seasonplot(stab,2)
# v hv verified graphically it is not stat
# next verify statistically if it is stat
# statistically we need to test out if the series is stationary or not
# Augmented Dickey Fuller Test
library(tseries)
adf.test(data)
plot(data)
# if the p-value is less than 0.05,
# then the time series is stationary, else not
# what kind of forecsating models v can use
# Time Series Forecasting Models# Simple Exponential Smoothing
# Double Expo. Smoothing
# Tripple Expo. Smoothing
# AR-I-MA model, this is the most imp model,
# also known as box-jenkins methodology
# first arima
# arima model is explained using p,q,d
# p stands for pacf
# d for differencing
# q for acf
# if v can identify p d q from graph
# then it bcms ez to draw ts graph
#lets look at a use case
AirPassengers
plot(AirPassengers)
# air passngrs r increasing over time
# v need to find the order from arima
# order of the ARIMA model
# v need to find p q d
# b4 that v can do the forecasting using auto arima
auto.arima(AirPassengers)auto.arima(AirPassengers,trace=T)
# this auto dcds the pars for p q d
# this indciates there r 2 kinds of models which can fit
# where the vals of p q d are 2,1,1 or 0,1,0
# if v test for stat ntc it is so v can go ahead and build the model
adf.test(AirPassengers)
#but if v look at the acf
acf(AirPassengers)
# it is sloping downwards but never bcoming 0
# if v look at pacf
pacf(AirPassengers)
# after lag of 1
# it immed drops to 0 and after the 8th lag it incresaes to 0.1
# and then drops
#ntc when v run
auto.arima(AirPassengers)
"
These r 6 pars v hv P D Q & p d q
it is capturing the seasonal comp and auto.arima is auto idetifying this
and from this it is computing AICc = 1020.73"model2<-auto.arima(AirPassengers)
plot(forecast(model2,h=12))
#this forecasts for period of 12
#now lets tk a look at our sales data
data
# remem it shows it is not stat
adf.test(data)
# this means v need to do sm transformations here
# lets start with log transf
adf.test(log(data))
adf.test(diff(data))
# diff is the dfrn btw actual data pt and prev data pt
diff(data)
data
#ntc -1 is 741 -742
# since it is stat v can now apply forecasting on the diffrencd data
plot(diff(data))
# v can also create 2 or 3 period dfrrncs
diff(data,differences = 2)
# ideally 1 diff is good and v shld not go more than this# ie do the drnc verify the stat
# if not do the dfrnc with 2 and verify again
# never go beyond it
#
auto.arima(diff(data))
# now ntc v get p comp is 1, d is 0 and q is 2
# ntc ar1 is used as auto reg componetn
# also ntc ma1 whi is mving avg1 & 2
# ie 1 perio moving avg and 2 period mvng avg
# why 2 period mvg avgs
# coz it is associated with acf
# ar1 is associated with pacf
# dfrnc is not included coz v alrd dfrnc it
# so arima model will not dfrnc it
model3<-auto.arima(diff(data))
# how to know the vals of p & q by looking at the graphs
acf(diff(data))
# if the corr is dropping siginficantly which is shown by the dotted line
# which is the order
# here if u ntc for lag2 with 0 based indx
# it is touching below the dotted line of the below dotted line# so acf is 2
# now when v run this
pacf(diff(data))
# ntc this removes the seasonal comp
# and it is lag1 which is going below the below dotted line
# so in the arima model v r getting pacf as 1
# lets tk these vals
# this is calld changing the order
Arima(diff(data),order=c(4,0,5))
# ntc the aic= 669.69
Arima(diff(data),order=c(3,0,4))
#Arima(data,order=c(3,0,5))
Arima(diff(data),order=c(4,0,4))
#ntc the aic is incr to 750.94
# lower the aic the btr the model is
Arima(diff(data),order=c(0,0,1))
Arima(diff(data),order=c(1,0,0))Arima(diff(data),order=c(1,0,1))
Arima(diff(data),order=c(1,0,2))
Arima(diff(data),order=c(1,1,3))
# so wht v r doing is manually calc the arima pars
# so it is not necessary
# ie auto.arima gvs us the best
# so what do v do
# v use mape
# MAPE = mean absolute percentage error
# (ideally it shld b lt < 10% to b a good model)
plot(forecast(model3,h=12))
# this is calld 12 period advncd forcst
# this is pathetic
# gray lines indicate confid interval
# so what do v do
# how to get a good prediction
# v can use moving avgs
# there r mult moving avg comps
# 3 period vs 4 per ...
# but mainly CMA for central m a# FMA for forward m a
# & 3 or 5 period m a
# if the series is not stat then v shld not apply arima
# the series v hv is real world sales data
# and it is complex series
# if v try to plot a log of data
plot(log(data))
# ntc it is not stat and v cannot apply arima models
# another model is holt winters exp smoothing
# this has mult options to find trend and seasonality comps
# if it is stationary then v can use simple exp smoothing
# if it is not hving trend use double exp smoothing
# if it is hving trend & seasonal comps
# then use triple exp smoothing
# in this
plot(log(data))
# v hv trend, seas & cyclicity also
# so v shld use exp smoothing models
# Holt Winters Exponential Smoothing Model
# if series is stationary then use simple exponential smoothing modelmodel4<-HoltWinters(data,beta = F, gamma = F)
summary(model4)
model4
library(forecast)
plot(forecast(model4,12))
# actually this is not working as it is not stat
# Holt Winters Exponential Smoothing Model
# if series is not stationary and only trend component is present,
# then use double exponential smoothing model
model5<-HoltWinters(data,gamma = F)
summary(model5)
model5
plot(forecast(model5,12))
# Frm this v say to sm extent it captures the trend
# but the seasonal and irregular comps r not captured
# Holt Winters Exponential Smoothing Model
# if series is not stationary and
# trend and seasonality component is present,
# then use tripple exponential smoothing model
model6<-HoltWinters(data)summary(model6)
model6
# These coeffs r 12 coeffs
# a is intercept
# b is trend
# s1 to s12 r seasonal comps
# these coeffs r beta coeffs
"Coefficients:
[,1]
a 970.571884
b -42.331143
s1 38.713698
s2 -15.936653
s3 34.078847
s4 -63.295181
s5 -80.085910
s6 55.488371
s7 -94.214048
s8 -62.216597
s9 -47.603478
s10 33.357650
s11 0.978706
s12 -53.359675"
# the smoothing pars
# alpha is if the series is stat# beta is the T comp, here beta is high and it means it is impacting
# gama is the S comp, this also has a significant impact, on the final outcome var
plot(forecast(model6,12))
# this looks like it has a trend seas & irreg comps whi is btr than the rest of em
# arima ds not work if v hv T, S or Irr comps
# to incr the accuracy v can try this
plot(forecast(model6,3))
# if v hv too many jerks ie too many fluctuations
# in such a case v forecast for less months
plot(forecast(model6,24)) #24 months
# for accuracy
mean(abs(model2$residuals))*100 # mape 786
mean(abs(model3$residuals))*100 # mape 13259
mean(abs(model4$residuals))*100 # Here the resid comp is able to extract
mean(abs(model5$residuals))*100 # Here the resid comp is able to extract
mean(abs(model6$residuals))*100 # Here the resid comp is able to extract
summary(model5)
data
model5$fitted # these r our forecasted vals
tab<-(model5$fitted)tab[,1] # extract first col which is x hat which is fitted vals
# mape = actual - fitted vals is the residuals
# this is manual way
# There is also another way of doing automatic forecasting using exp smoothin model
# coz v do not know if there is T,S, or I comps
# Automatic Exponential Smoothing Model
model7<-ets(data) # here v dont need to worry abt alph beta or gama
summary(model7)
model7
# ntc mape is 12% which is good
# and it is automaticlaly identifying the order
# if u r not sure what kind of models u need to use
# then use ets
# first it needs to be statnry, if it is go ahead with arima
# if not use auto exp smoothing
# if auto exp S is not giving good results
# then go for manual smoothing
# if it ds not work here v can also try transformations
# such as diff based, log based, exp based
# whichever gvs the best mape or aic is the best
#***