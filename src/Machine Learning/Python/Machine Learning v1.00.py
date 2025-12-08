# ML without Partitioning & without Pre-processing
from IPython.core.display import Image, display
display(Image(r'E:\\Locker\\Sai\\SaiHCourseNait\\DecBtch\\R_Datasets\\iris_setosa.jpg'))
display(Image(r'E:\\Locker\\Sai\\SaiHCourseNait\\DecBtch\\R_Datasets\\iris_versicolor.jpg'))
display(Image(r'E:\\Locker\\Sai\\SaiHCourseNait\\DecBtch\\R_Datasets\\iris_virginica.jpg'))
from sklearn.datasets import load_iris
# this is built in dataset
iris = load_iris()
print(iris)
# it is a dict of keys & vals
iris.keys()
# this gvs us keys
iris['data']
iris['target']
iris.values()iris.data.shape
# this gvs us the dims
# our ip data has 150 obs & 4 vars
iris.feature_names
# these r the vars or features or ivs
iris.target_names
# these r the vals of target or dv
iris.target
# this is dep var vals
### Logistic Regression ###
from sklearn.linear_model import LogisticRegression
model = LogisticRegression()
model.fit(iris.data,iris.target) # train
expectedoutcome = iris.target # test
predicted = model.predict(iris.data) # predictfrom sklearn import metrics
# true vals vs predicted vals
print(metrics.confusion_matrix(expectedoutcome,predicted)) #
from sklearn.metrics import accuracy_score
score = accuracy_score(iris.target, predicted)
score
### Naives Bayes ###
from sklearn.naive_bayes import GaussianNB
model = GaussianNB()model.fit(iris.data,iris.target)
expected = iris.target
predicted = model.predict(iris.data)
print(metrics.accuracy_score(expected,predicted))
### SVM ###
from sklearn.svm import SVC
model = SVC()
model.fit(iris.data,iris.target)
expected = iris.target
predicted = model.predict(iris.data)print(metrics.accuracy_score(expected,predicted))
### Diabetes Data ### # ML & Partitioning & wo Pre-processing
url = "https://archive.ics.uci.edu/ml/machine-learning-databases/pima-indians-diabetes/pima-indiansdiabetes.data"
names = ['preg','plas','pres','skin','test','mass','pedi','age','class']
import pandas as pd
df = pd.read_csv(url,names=names)df.head()
array = df.values
array
X = array[:,0:8] # ivs for train
X
y = array[:,8] # dv
y
test_size = 0.33
from sklearn.model_selection import train_test_split
#pip install -U scikit-learn
X_train,X_test,y_train,y_test = train_test_split(X,y,test_size=test_size)
### KNN ###
from sklearn.neighbors import KNeighborsClassifier
model = KNeighborsClassifier()model.fit(X_train,y_train)
prediction = model.predict(X_test)
outcome = y_test
print(metrics.accuracy_score(outcome,prediction)) # true vals vs predicted vals
model = KNeighborsClassifier(7)
model.fit(X_train,y_train)
prediction = model.predict(X_test)
outcome = y_test
print(metrics.accuracy_score(outcome,prediction)) # true vals vs predicted vals### Decision Tree
from sklearn.tree import DecisionTreeClassifier
model = DecisionTreeClassifier()
model.fit(X_train,y_train)
prediction = model.predict(X_test)
outcome = y_test
print(metrics.accuracy_score(outcome,prediction))# ML w Partitioning & Pre-processing
#Feature selection
from sklearn.feature_selection import SelectKBest, chi2
X_train,X_test,y_train,y_test = train_test_split(X,y,test_size=test_size)
print(df.shape)
# v hv 8 features or ivs & 1 DV in other words v r using all the features
df.head()
test = SelectKBest(score_func=chi2,k=4) # Select top 4 features
fit = test.fit(X,y)
import numpy as np
np.set_printoptions(precision=3)
print(fit.scores_) # gvs the features for each of the scores
print('***************** Higher the score better the features predict ***********************')features = fit.transform(X) #
print(features[0:5,:]) # print 5 rows all features which is only 4 cols or 4 features
# Lets try the features on the model
#from sklearn.linear_model import LogisticRegression
#from sklearn.model_selection import train_test_split
logreg = LogisticRegression()
X_train,X_test,y_train,y_test = train_test_split(X,y)
# this is using all features and v hv not done the feature selection here
logreg.fit(X_train,y_train)
logreg.score(X_test,y_test) #this gvs the accuracy
#so lets rerun with feature selection with only selected features
logreg = LogisticRegression()
X_train,X_test,y_train,y_test = train_test_split(features,y) # v r using features instead of X
logreg.fit(X_train,y_train)
logreg.score(X_test,y_test) # It may worsening here sometimes
#***# recursive feature elimination, feature selection technique
# gvs the combination of features which gv btr accuracy
#from sklearn.linear_model import LogisticRegression
#from sklearn.model_selection import train_test_split
logreg = LogisticRegression()
from sklearn.feature_selection import RFE
#rfe = RFE(model,3) # v will use 3 features only best combination of 3 features
rfe = RFE(logreg,3) # v will use 3 features only best combination of 3 features
import sklearn
print('The scikit-learn version is {}.'.format(sklearn.__version__))fit = rfe.fit(X,y)
print("Number of features: %d " % fit.n_features_) # gvs num of features
print("Selected features: %s " % fit.support_) # gvs bool vals, which features hv been selected by feature
selection mod
print("Feature Ranking: %s " % fit.ranking_) # gvs
print("Features sorted by their rank:")
print(sorted(zip(map(lambda x: round(x, 4), rfe.ranking_), names)))### PCA ### Dim Reduction Techniq
# unlike SelectKBest it is not just eliminating the features
# but it is creating new features called as components
# so it is referred as a dim reduction techniq
df.head()
from sklearn.decomposition import PCA
pca = PCA(n_components=None)
fit = pca.fit(X)
print('Explained Variance Ratio %s: ', fit.explained_variance_ratio_)
#[ 8.885e-01 6.159e-02 2.579e-02 1.309e-02 7.441e-03 3.026e-03
# 5.124e-04 6.793e-06]
# First PC explains 88%
# First 2 PCs explain 88 + 6 = 94% and so on...
print(fit.components_)
pca = PCA(n_components=3)
fit = pca.fit(X)
print('Explained Variance Ratio %s: ', fit.explained_variance_ratio_)# Explained Variance Ratio %s: [ 0.889 0.062 0.026]
'''
First set of components capture 88.9% of the variance
and the second set of components 6%
This is the first component
[ -2.022e-03 9.781e-02 1.609e-02 6.076e-02 9.931e-01 1.401e-02
5.372e-04 -3.565e-03]
and so on...
'''### Extra Tree Classifier ### fourth technique
from sklearn.ensemble import ExtraTreesClassifier
model = ExtraTreesClassifier()
model.fit(X,y)
print(model.feature_importances_)
# The higher the vals the btr the features are
# drop the low val features### Pre processing techniques ###
seed = np.random.seed(3)
test_size = 0.33
X_train,X_test,y_train,y_test = train_test_split(X,y,random_state=seed)
print(df.head())
model = LogisticRegression()
model.fit(X_train, y_train)
print(model.score(X_test,y_test)) # Normal model wo fea selctionrfe = RFE(model,6) # 6 is hyper par
training = rfe.fit(X_train,y_train)
applied = training.transform(X_train)
print(applied)
model2 = LogisticRegression()
model2.fit(applied,y_train) # this is transformed data
testdata = training.transform(X_test)
model2.score(testdata,y_test)
me = np.array([0,150,70,30,0,40,0.5,28]) # new vals for prediction
me
me_adjusted = me.reshape(1,-1) # in new vers of numpy this is reqd when v hv 1 obs
me_adjustedme_adjusted = training.transform(me_adjusted)
me_adjusted # only 6 are left
model2.predict(me_adjusted)
# Dummy Vars & Encoders
from numpy import array
from numpy import argmax
from sklearn.preprocessing import LabelEncoder
from sklearn.preprocessing import OneHotEncoder
dataset = ['Pizza','Burger','Bread','Bread','Bread','Burger','Pizza','Burger']values = array(dataset)
print(values)
label_encoder = LabelEncoder()
integer_encoded = label_encoder.fit_transform(values)
print(integer_encoded)
onehot = OneHotEncoder(sparse=False)
integer_encoded = integer_encoded.reshape(len(integer_encoded),1)
onehot_encoded = onehot.fit_transform(integer_encoded)
print(onehot_encoded)
inverted_result = label_encoder.inverse_transform([argmax(onehot_encoded[0,:])])
print(inverted_result)import pandas as pd
pd.get_dummies(dataset)
# implement onehotencoding
import keras
from keras.utils import to_categorical
#ImportError: No module named 'keras'
# pip install keras
myarray = array(dataset)integer_encoded = label_encoder.fit_transform(myarray)
print(integer_encoded)
kerasencoded = to_categorical(integer_encoded)
print(kerasencoded)
# Handle missing vals in keras
# In[8]:
import pandas as pddataset = pd.read_csv("E:\\Locker\\Sai\\SaiHCourseNait\\DecBtch\\R_Datasets\\pima-indiansdiabetes.csv",header=None)
print(dataset.head(15))
# ntc the 5th col is bmi
# and is gen not 0 but v hv a lot of 0 vals
print(dataset[[1,2,3,4,5]].head()) # first 5 rows and cols
print(dataset[[1,2,3,4,5]]==0)
print((dataset[[1,2,3,4,5]]==0).sum())
# this gvs the num of 0 vals v hv in first 5 cols
# ntc 3 & 4 hv unusual num of 0s
# 3rd col is triceps skinfold thickness
# 4th col is 2-hour serum# missing vals to nans
import numpy as np
dataset[[1,2,3,4,5]] = dataset[[1,2,3,4,5]].replace(0,np.NaN)
print(dataset.head(15))
from sklearn.discriminant_analysis import LinearDiscriminantAnalysis
from sklearn.model_selection import KFold
from sklearn.model_selection import cross_val_score
values = dataset.values
X = values[:,0:8]
y = values[:,8]
model = LinearDiscriminantAnalysis()
kfold = KFold(n_splits=3,random_state=7)
result = cross_val_score(model,X,y,cv=kfold,scoring="accuracy")
print(result.mean()) # v shd get this#ValueError: Input contains NaN, infinity or a value too large for dtype('float64').
# impute msng vals
# first technq is drop all rows with nas
import numpy as np
dataset[[1,2,3,4,5]] = dataset[[1,2,3,4,5]].replace(0,np.NaN)
dataset.dropna(inplace=True)
print(dataset.head(15)) #ntc row indx# now lets predict
from sklearn.discriminant_analysis import LinearDiscriminantAnalysis
from sklearn.model_selection import KFold
from sklearn.model_selection import cross_val_score
values = dataset.values
X = values[:,0:8]
y = values[:,8]
model = LinearDiscriminantAnalysis()
kfold = KFold(n_splits=3,random_state=7)
result = cross_val_score(model,X,y,cv=kfold,scoring="accuracy")
print(result.mean())# nxt tchnq lets use mean for imputing
dataset = pd.read_csv("E:\\Locker\\Sai\\SaiHCourseNait\\DecBtch\\R_Datasets\\pima-indiansdiabetes.csv",header=None)
dataset[[1,2,3,4,5]] = dataset[[1,2,3,4,5]].replace(0,np.NaN)
dataset.fillna(dataset.mean(),inplace=True)
#print(dataset.head(15))
from sklearn.discriminant_analysis import LinearDiscriminantAnalysis
from sklearn.model_selection import KFold
from sklearn.model_selection import cross_val_score
values = dataset.values
X = values[:,0:8]
y = values[:,8]
model = LinearDiscriminantAnalysis()
kfold = KFold(n_splits=3,random_state=7)
result = cross_val_score(model,X,y,cv=kfold,scoring="accuracy")
print(result.mean()) # 76.6%, ntc it has worsened# nxt tchnq use imputer instd of mean
from sklearn.preprocessing import Imputer
dataset = pd.read_csv("E:\\Locker\\Sai\\SaiHCourseNait\\DecBtch\\R_Datasets\\pima-indiansdiabetes.csv",header=None)
dataset[[1,2,3,4,5]] = dataset[[1,2,3,4,5]].replace(0,np.NaN)
#print(dataset.head(15))
from sklearn.discriminant_analysis import LinearDiscriminantAnalysis
from sklearn.model_selection import KFold
from sklearn.model_selection import cross_val_score
values = dataset.values
imputer = Imputer()
values = imputer.fit_transform(values) #by default imputer uses mean
X = values[:,0:8]
y = values[:,8]
model = LinearDiscriminantAnalysis()
kfold = KFold(n_splits=3,random_state=7)
result = cross_val_score(model,X,y,cv=kfold,scoring="accuracy")
print(result.mean()) # 76.6%
# so what shd v do
# v cld incr the n_splits and try againmodel = LogisticRegression()
#kfold = KFold(n_splits=3,random_state=7)
result = cross_val_score(model,X,y,cv=kfold,scoring="accuracy")
print(result.mean())
model = XGBClassifier()
#kfold = KFold(n_splits=3,random_state=7)
result = cross_val_score(model,X,y,cv=kfold,scoring="accuracy")
print(result.mean())### Rescaling ### or Normalization
# MLs put higher wtage on features which hv higher scale
#print(array)
print(X)
#print(y)
#df.head()
from sklearn.preprocessing import MinMaxScaler
scaler = MinMaxScaler(feature_range=(0,1)) # Scaling data btw 0 & 1
rescaled = scaler.fit_transform(X)
np.set_printoptions(precision=3)
print(rescaled[0:5,:])
print(X)# Standardization, mean of 0 and sd of 1, gaussian distrib
# Linear Reg, Log Reg, LDA
from sklearn.preprocessing import StandardScaler
scaler2 = StandardScaler()
rescaled2 = scaler2.fit_transform(X)
print(rescaled2[0:5,:])
# vals with a mean of 0 & sd of 1
# takes ea feature val
# calcs the mean of ea fea
# subtracts the mean
# then div by sd
# then v get these values
# this is the 2nd pre-processing technique# Normalization, when v hv a lot of 0 vals, missing vals
# or attrs of varying scale used in NNs, KNNs
# rescaling ea obs to a len of 1 called unit norm in linear alg
from sklearn.preprocessing import Normalizer
scaler3 = Normalizer()
rescaled3 = scaler3.fit_transform(X)
print(rescaled3[0:5,:])# Binarizer, make data binary
# set a threshold,
# anything abv thr is 1 or 0 and viceversa
from sklearn.preprocessing import Binarizer
scaler4 = Binarizer(threshold=0.0) # thr is 0
rescaled4 = scaler4.fit_transform(X)
print(rescaled4[0:5,:])
# Feature Scaling Project
from sklearn.linear_model import Ridge
from sklearn.metrics import mean_squared_error, r2_score
url = "http://mlr.cs.umass.edu/ml/machine-learning-databases/wine-quality/winequality-red.csv"df = pd.read_csv(url,sep=';')
df.head()
y = df.quality
y.head()
X = df.drop('quality',axis=1)
X.head()
X_train,X_test,y_train,y_test = train_test_split(X,y,test_size=test_size, random_state=123, stratify=y)
# for reproduceability
# stratified sampling
clf = Ridge()
clf.fit(X_train,y_train)
prediction = clf.predict(X_test)
print(r2_score(y_test,prediction))
print(mean_squared_error(y_test,prediction))
scaler = StandardScaler()
X_train_scaled = scaler.fit_transform(X_train)
X_test_scaled = scaler.fit_transform(X_test)
clf2 = Ridge()
clf2.fit(X_train_scaled,y_train)prediction2 = clf2.predict(X_test_scaled)
print(r2_score(y_test,prediction2))
print(mean_squared_error(y_test,prediction2)) # slightly better# Best Algorithms, which perform best
# ensembles
from sklearn import model_selection
from sklearn.ensemble import BaggingClassifier
from sklearn.tree import DecisionTreeClassifier
#url = "https://archive.ics.uci.edu/ml/machine-learning-databases/pima-indians-diabetes/pima-indiansdiabetes.data"
#names = ['preg','plas','pres','skin','test','mass','pedi','age','class']
#import pandas as pd
#df = pd.read_csv(url,names=names)
df.head()
array = df.values
X = array[:,0:8]
y = array[:,8]
seed = 7
kfold = model_selection.KFold(n_splits=10, random_state=seed)
cart = DecisionTreeClassifier()
num_trees = 100
model = BaggingClassifier(base_estimator=cart, n_estimators=num_trees,random_state=seed)
#base_estmr is the ML algo v want to use
#n_estmtrs is how many trees v want to build
results = model_selection.cross_val_score(model,X,y,cv=kfold)
print(results.mean())#v r taking 100 trees and then taking the mean
# A simple DecisionTree for comparison instead of bagging classifier wo cv
model2 = DecisionTreeClassifier()
results2 = model_selection.cross_val_score(model2,X,y,cv=kfold)
print(results2.mean())# RF also another Bagging classifier
from sklearn.ensemble import RandomForestClassifier
max_features = 3 #4,5,7
model3 = RandomForestClassifier(n_estimators=num_trees,max_features=max_features)
results3 = model_selection.cross_val_score(model3,X,y,cv=kfold)
print(results3.mean())
# Extra trees classifier
from sklearn.ensemble import ExtraTreesClassifier
max_features2 = 7
model4 = ExtraTreesClassifier(n_estimators=num_trees,max_features=max_features2)
results4 = model_selection.cross_val_score(model4,X,y)
print(results4.mean())
max_features2 = 7
model4 = ExtraTreesClassifier(n_estimators=num_trees,max_features=max_features2)
results4 = model_selection.cross_val_score(model4,X,y,cv=kfold)print(results4.mean())
# Adaboost
from sklearn.ensemble import AdaBoostClassifier
num_trees2 = 30
max_features2 = 7
model5 = AdaBoostClassifier(n_estimators=num_trees2,random_state=seed)
results5 = model_selection.cross_val_score(model4,X,y,cv=kfold)
print(results5.mean())# SGBoosting, one of the best techniqs
from sklearn.ensemble import GradientBoostingClassifier
num_trees3 = 100
model6 = GradientBoostingClassifier(n_estimators=num_trees3,random_state=seed)
results6 = model_selection.cross_val_score(model6,X,y,cv=kfold)
print(results6.mean())
# First XGBoost model for Pima Indians dataset
'''How to Install in the simplest way:
1. Download the Appropriate .whl file for your environment from
https://www.lfd.uci.edu/~gohlke/pythonlibs/#xgboost
2. Open your command prompt and cd into the downloaded folder.
I’ve downloaded the .whl file inside xgbinstall folder in the Desktop.
3. Now simply issue the pip install command to the downloaded .whl file like so:
pip install xgboost-0.6-cp36-cp36m-win_amd64.whl'''
from numpy import loadtxt
from xgboost import XGBClassifier
from sklearn.model_selection import train_test_split
from sklearn.metrics import accuracy_score
# split data into train and test sets
seed = 7
test_size = 0.33
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=test_size, random_state=seed)
# fit model no training data
model = XGBClassifier()
model.fit(X_train, y_train)
# make predictions for test data
y_pred = model.predict(X_test)
predictions = [round(value) for value in y_pred]
# evaluate predictions
accuracy = accuracy_score(y_test, predictions)
print("Accuracy: %.2f%%" % (accuracy * 100.0))
results6 = model_selection.cross_val_score(model,X,y,cv=kfold)
print(results6.mean())# Final ensemble technique
from sklearn.tree import DecisionTreeClassifier
from sklearn.svm import SVC
from sklearn.linear_model import LogisticRegression
from sklearn.ensemble import VotingClassifier
estimators = []
model7 = LogisticRegression()
estimators.append(('logistic',model7))
model8 = DecisionTreeClassifier()
estimators.append(('cart',model8))
model9 = SVC()
estimators.append(('svm',model9))
model10 = XGBClassifier()
estimators.append(('xgb',model10))ensemble = VotingClassifier(estimators)
results7 = model_selection.cross_val_score(ensemble,X,y,cv=kfold)
print(results7.mean())# Model selection Cross Validation Score
# Hw to get the best results
# Partitioning vs CV
#url = "https://archive.ics.uci.edu/ml/machine-learning-databases/pima-indians-diabetes/pima-indiansdiabetes.data"
#names = ['preg','plas','pres','skin','test','mass','pedi','age','class']
#import pandas as pd
#df = pd.read_csv(url,names=names)
#df.head()
#array = df.values
#X = array[:,0:8]
#y = array[:,8]
#seed = 7
df.head()
#X_train,X_test,y_train,y_test = train_test_split(X,y,test_size=test_size)
#X
#from sklearn.model_selection import KFold
#from sklearn.model_selection import cross_val_score
#kfold = KFold(n_splits=10,random_state=7)
model = LogisticRegression()
model.fit(X_train,y_train)
result = model.score(X_test,y_test)print("Accuracy with partitioning:{}".format(result))
model2 = LogisticRegression()
results = cross_val_score(model2,X,y,cv=kfold)
print("Accuracy with CV:{}".format(results.mean()))
# Model Par Tuning/Hyper par optimization# Create Best Model with best pars
# GridsearchCv RandomSearchCV
from sklearn import datasets
from sklearn.linear_model import Ridge
from sklearn.model_selection import GridSearchCV
import numpy as np
dataset = datasets.load_diabetes()
dataset
alphas = np.array([1,0.1,0.01,0.001,0.0001,0])
model = Ridge()
grid = GridSearchCV(estimator=model,param_grid=dict(alpha=alphas))
grid.fit(dataset.data,dataset.target)
print(grid.best_score_)
print(grid.best_estimator_.alpha)### Random Search A second method to tune algo ###
from scipy.stats import uniform as sp_rand
from sklearn import datasets
from sklearn.linear_model import Ridge
from sklearn.model_selection import RandomizedSearchCV
datasets = datasets.load_diabetes()
param_grid = {'alpha':sp_rand()}
model = Ridge()
rsearch = RandomizedSearchCV(estimator=model, param_distributions=param_grid, n_iter = 100)
rsearch.fit(dataset.data, dataset.target)
print(rsearch.best_score_)
print(rsearch.best_estimator_.alpha)### Automate ML using Pipelines ###
df.head()
from sklearn.pipeline import Pipeline
from sklearn.discriminant_analysis import LinearDiscriminantAnalysis
from sklearn.preprocessing import StandardScaler
X
estimators = []
estimators.append(('standardize',StandardScaler()))
estimators.append(('lda',LinearDiscriminantAnalysis()))
model = Pipeline(estimators)
seed = 7
kfold = KFold(n_splits=10, random_state=seed)
results = cross_val_score(model, X,y, cv=kfold)
print(results.mean())from sklearn.pipeline import FeatureUnion
from sklearn.decomposition import PCA
from sklearn.feature_selection import SelectKBest
features = []
features.append(('pca',PCA(n_components=3)))
features.append(('select_kbest',SelectKBest(k=6)))
feature_union = FeatureUnion(features)
estimators = []
estimators.append(('feature_union',feature_union))
estimators.append(('logistic',LogisticRegression()))model = Pipeline(estimators)
seed = 7
kfold = KFold(n_splits=10,random_state=seed)
results = cross_val_score(model,X,y,cv=kfold)
print(results.mean())
### How to compare ML algos ###
import matplotlib.pyplot as plt
from sklearn.discriminant_analysis import LinearDiscriminantAnalysis
from sklearn.naive_bayes import GaussianNB
from sklearn.neighbors import KNeighborsClassifier
models = []
models.append(('Log Reg',LogisticRegression()))
models.append(('LDA',LinearDiscriminantAnalysis()))
models.append(('KNN',KNeighborsClassifier()))
models.append(('CART',DecisionTreeClassifier()))
models.append(('NB',GaussianNB()))
models.append(('SVM',SVC()))
models.append(('XGB',XGBClassifier()))results = []
names = []
scoring = 'accuracy'
for name,model in models:
kfold = model_selection.KFold(n_splits=10,random_state=seed)
cv_results = model_selection.cross_val_score(model,X,y,cv=kfold,scoring=scoring)
results.append(cv_results)
names.append(name)
msg = "%s: %f (%f)" % (name, cv_results.mean(), cv_results.std())
print(msg)
fig = plt.figure()
fig.suptitle('Algo Comparison ')
ax = fig.add_subplot(111)
plt.boxplot(results)
ax.set_xticklabels(names)
plt.show()
