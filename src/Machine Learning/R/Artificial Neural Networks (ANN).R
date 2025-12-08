# Artificial Neural Network

getwd()

setwd("E:\\Locker\\Sai\\SaiHCourseNait\\DecBtch\\R_Datasets")

getwd()


# Importing the dataset
dataset = read.csv('Churn_Modelling.csv')
dataset = dataset[4:14]

# Encoding the categorical variables as factors
dataset$Geography = as.numeric(factor(dataset$Geography,
                                      levels = c('France', 'Spain', 'Germany'),
                                      labels = c(1, 2, 3)))
dataset$Gender = as.numeric(factor(dataset$Gender,
                                   levels = c('Female', 'Male'),
                                   labels = c(1, 2)))

# Splitting the dataset into the Training set and Test set
# install.packages('caTools')
library(caTools)
set.seed(123)
split = sample.split(dataset$Exited, SplitRatio = 0.8)
training_set = subset(dataset, split == TRUE)
test_set = subset(dataset, split == FALSE)
head(training_set)
head(test_set)

# Feature Scaling
training_set[-11] = scale(training_set[-11])

head(training_set)

test_set[-11] = scale(test_set[-11])

head(test_set)

# Fitting ANN to the Training set
#install.packages('h2o')
library(h2o)
h2o.init(nthreads = -1)
"
model = h2o.deeplearning(y = 'Exited',
                         training_frame = as.h2o(training_set),
                         activation = 'Rectifier',
                         hidden = c(5,5),
                         epochs = 100,
                         train_samples_per_iteration = -2)
"
model = h2o.deeplearning(y = 'Exited',
                         training_frame = as.h2o(training_set),
                         activation = 'Tanh',
                         hidden = c(10,5),
                         epochs = 100,
                         train_samples_per_iteration = -2)


# Predicting the Test set results
y_pred = h2o.predict(model, newdata = as.h2o(test_set[-11]))
y_pred = (y_pred > 0.5)
y_pred = as.vector(y_pred)

# Making the Confusion Matrix
tCM = table(test_set[, 11], y_pred)
tCM
sum(diag(tCM))/sum(tCM)

h2o.shutdown()
Y
