from nltk.corpus import movie_reviews

for category in movie_reviews.categories():
    print(category)

documents = [(list(movie_reviews.words(file_id)), category) for category in movie_reviews.categories() for file_id in
             movie_reviews.fileids(category)]
for words,category in documents[:3]:
	print(words)
	print(category,'\n\n')


random.shuffle(documents)
all_words = nltk.FreqDist([w.lower() for w in movie_reviews.words()])
print(len(set(all_words.keys())))
# gvs how many words are there

# 40000 words is a lot of words so v use limited num of words as features
word_features = list(all_words.keys())[:2000]
print(word_features[:20])

# custom features function for building a table
def feature_function(movie_review):
    document_words = set(movie_review)
    features = {}#dict()
    for word in word_features:
        features['contains' + word] = word in document_words
    return features


print(feature_function(movie_reviews.words('pos/cv957_8737.txt')))
# Containsboy: True, means this word exists in the feature table

# Feature set
feature_set = [(feature_function(document), category) for document, category in documents]
train_set = feature_set[100:]
test_set = feature_set[:100]
classifier = nltk.NaiveBayesClassifier.train(train_set)

print(classifier.classify(feature_function(movie_reviews.words('pos/cv001_18431.txt'))))
# this is a mov rev whi is lrdy clssfd as pos rev

print(classifier.classify(feature_function(movie_reviews.words('neg/cv999_14636.txt'))))

print(nltk.classify.accuracy(classifier, test_set))
print(classifier.show_most_informative_features())

'''0.8
Most Informative Features
          containsjustin = True              neg : pos    =      9.6 : 1.0
For every 9 movies justin is in neg reviews and 1 pos review
If v take 10 movie reviews
9 reviews which had neg has justin
1 review had pos with justin in it
   containsunimaginative = True              neg : pos    =      8.2 : 1.0
      containsschumacher = True              neg : pos    =      7.3 : 1.0
       containsatrocious = True              neg : pos    =      6.9 : 1.0
            containsmena = True              neg : pos    =      6.9 : 1.0
          containssuvari = True              neg : pos    =      6.9 : 1.0
          containsturkey = True              neg : pos    =      6.7 : 1.0
         containssingers = True              pos : neg    =      6.4 : 1.0
          containsshoddy = True              neg : pos    =      6.3 : 1.0
         containsjumbled = True              neg : pos    =      6.3 : 1.0
'''





#********************** Ham Spam

# **************** ham vs spam 


# Uncomment the code below and run:
# !conda install nltk #This installs nltk
# import nltk # Imports the library
# nltk.download() #Download the necessary datasets


# ## Get the Data
# dataset from the [UCI datasets](https://archive.ics.uci.edu/ml/datasets/SMS+Spam+Collection)! 

import os 
os.chdir('E:\\Locker\\Sai\\SaiHCourseNait\\DecBtch\\R_Datasets\\')

# The file we are using contains a collection of more than 5 thousand 
# SMS phone messages. 
# 
# use rstrip() to get a list of all the lines of text messages:

messages = [line.rstrip() for line in open('smsspamcollection/SMSSpamCollection')]
print(len(messages))


# A collection of texts is called "corpus". 

for message_no, message in enumerate(messages[:10]):
    print(message_no, message)
    print('\n')


# these labeled ham and spam examples, 
# we **train a machine learning model to learn to discriminate between 
# ham/spam automatically**. 
# Then, with a trained model, be able to 
# **classify arbitrary unlabeled messages** as ham or spam.
# 
# Instead of parsing TSV manually, we can just take advantage of pandas

import pandas as pd
messages = pd.read_csv('smsspamcollection/SMSSpamCollection', sep='\t',
                           names=["label", "message"])
messages.head()


# ## Exploratory Data Analysis
# 
# check some of the stats with some plots 

messages.describe()


# **groupby** to use describe by label, 
# this way begin to think about the features that separate ham and spam!
messages.groupby('label').describe()

# Feature engineering
# make a new column to detect how long the text messages are:
messages['length'] = messages['message'].apply(len)
messages.head()


# ### Data Visualization

import matplotlib.pyplot as plt
import seaborn as sns
get_ipython().magic('matplotlib inline')
messages['length'].plot(bins=50, kind='hist') 

messages['length'].plot(bins=150, kind='hist') 

# text length is a good feature to think about!
# the x-axis goes all the way to 1000ish, 
# this must mean that there is some really long messages
messages.length.describe()
#910 characters, use masking to find this message:

messages[messages['length'] == 910]['message'].iloc[0]

# Looks like we have some sort of Romeo sending texts! 
# try to see if message length is a distinguishing feature between ham and spam:
messages.hist(column='length', by='label', bins=50,figsize=(12,4))
# just basic EDA we've been able to discover a trend
# that spam messages tend to have more characters. 





# ## Text Pre-processing
# Our main issue with our data is that it is all in text format (strings). 
# The classification algorithms will need 
# of numerical feature vector in order to perform the classification task.
# There are actually many methods to convert a corpus to a vector format. 
# The simplest is the the [bag-of-words]
# approach, where each unique word in a text will be represented by one number.
# 
# 
# convert the raw messages (sequence of characters) into vectors (sequences of numbers).
# 
# split a message into its individual words and return a list. 
# remove very common words, ('the', 'a', etc..). 
# use NLTK library. 

# create a function that will process the string in the message column, 
# remove punctuation. 

import string
mess = 'Sample message! Notice: it has punctuation.'
# Check characters to see if they are in punctuation
nopunc = [char for char in mess if char not in string.punctuation]
nopunc

# Join the characters again to form the string.
nopunc = ''.join(nopunc)
nopunc


# remove stopwords. We can impot a list of english stopwords from NLTK 
from nltk.corpus import stopwords
stopwords.words('english')[0:10] # Show some stop words

nopunc.split()


# remove any stopwords
clean_mess = [word for word in nopunc.split() if word.lower() not in stopwords.words('english')]
clean_mess

# put both of these together in a function to apply to DataFrame :
def text_process(mess):
    """
    Takes in a string of text, then performs the following:
    1. Remove all punctuation
    2. Remove all stopwords
    3. Returns a list of the cleaned text
    """
    # Check characters to see if they are in punctuation
    nopunc = [char for char in mess if char not in string.punctuation]

    # Join the characters again to form the string.
    nopunc = ''.join(nopunc)
    
    # Now just remove any stopwords
    return [word for word in nopunc.split() if word.lower() not in stopwords.words('english')]

# the original DataFrame:
messages.head()


# "tokenize" these messages. 
# Check to make sure its working
messages['message'].head(5).apply(text_process)
# Show original dataframe
messages.head()


# ### Continuing Normalization
# 
# There are a lot of ways to continue normalizing this text. 
# Such as [Stemming]
#     
#     'Nah dawg, IDK! Wut time u headin to da club?'
#     
# versus
# 
#     'No dog, I don't know! What time are you heading to the club?'
#     
# 

# ## Vectorization

# we have the messages as lists of tokens (also known as [lemmas]
# and now we need to convert each of those messages into a vector 
# so the SciKit Learn's algorithm models can work with.
# 
# Now we'll convert each message, represented as a list of tokens (lemmas) above, 
# into a vector that machine learning models can understand.
# 
# three steps using the bag-of-words model:
# 
# 1. Count how many times does a word occur in each message (Known as term frequency)
# 
# 2. Weigh the counts, so that frequent tokens get lower weight (inverse document frequency)
# 
# 3. Normalize the vectors to unit length, to abstract from the original text length (L2 norm)
# 

# Each vector will have as many dimensions as there are unique words in the SMS corpus.
# use **CountVectorizer**. This model will convert a collection of text documents 
# to a matrix of token counts.
# 
# We can imagine this as a 2-Dimensional matrix. 
# Where the 1-dimension is the entire vocabulary (1 row per word) and 
# the other dimension are the actual documents, 
# in this case a column per text message. 
# 
# 


from sklearn.feature_extraction.text import CountVectorizer
# There are a lot of arguments and parameters that can be passed to 
# the CountVectorizer. 
# v v time consuming more than 5 to 10 mins
bow_transformer = CountVectorizer(analyzer=text_process).fit(messages['message'])
# Print total number of vocab words
print(len(bow_transformer.vocabulary_))


# take one text message and get its bag-of-words counts as a vector, 
# putting to use `bow_transformer`:
message4 = messages['message'][3]
print(message4)


# vector representation:
bow4 = bow_transformer.transform([message4])
print(bow4)
print(bow4.shape)


# there are seven unique words in message number 4 (after removing common stop words). 
# Two of them appear twice, the rest only once. 
print(bow_transformer.get_feature_names()[4073])
print(bow_transformer.get_feature_names()[9570])


# transform the entire DataFrame of messages. 
#bag-of-words counts for the entire SMS corpus is a large, sparse matrix:
# v time consuming
messages_bow = bow_transformer.transform(messages['message'])
print('Shape of Sparse Matrix: ', messages_bow.shape)
print('Amount of Non-Zero occurences: ', messages_bow.nnz)


sparsity = (100.0 * messages_bow.nnz / (messages_bow.shape[0] * messages_bow.shape[1]))
print('sparsity: {}'.format(round(sparsity)))


# After the counting, the term weighting and normalization can be done with [TF-IDF]
from sklearn.feature_extraction.text import TfidfTransformer
tfidf_transformer = TfidfTransformer().fit(messages_bow)
tfidf4 = tfidf_transformer.transform(bow4)
print(tfidf4)


# what is the IDF (inverse document frequency) of the word `"u"` and of 
# word `"university"`?
print(tfidf_transformer.idf_[bow_transformer.vocabulary_['u']])
print(tfidf_transformer.idf_[bow_transformer.vocabulary_['university']])


# transform the entire bag-of-words corpus into TF-IDF corpus at once:
messages_tfidf = tfidf_transformer.transform(messages_bow)
print(messages_tfidf.shape)


# There are many ways the data can be preprocessed and vectorized. 
# These steps involve feature engineering and building a "pipeline". 
# ## Training a model
# With messages represented as vectors, train our spam/ham classifier. 
# Now we can actually use almost any sort of classification algorithms.
from sklearn.naive_bayes import MultinomialNB
spam_detect_model = MultinomialNB().fit(messages_tfidf, messages['label'])


# classify our single random message and check:
print('predicted:', spam_detect_model.predict(tfidf4)[0])
print('expected:', messages.label[3])


# predict spam vs ham classification!
# 
# Model Evaluation
# determine how well our model will do overall on the entire dataset. 
all_predictions = spam_detect_model.predict(messages_tfidf)
print(all_predictions)


from sklearn.metrics import classification_report
print (classification_report(messages['label'], all_predictions))


# ## Train Test Split
from sklearn.model_selection import train_test_split
msg_train, msg_test, label_train, label_test = train_test_split(messages['message'], messages['label'], test_size=0.2)
print(len(msg_train), len(msg_test), len(msg_train) + len(msg_test))


# The test size is 20% of the entire dataset (1115 messages out of total 5572), 
# and the training is the rest (4457 out of 5572). 
# 
# ## Creating a Data Pipeline
# 
# run our model again and then predict off the test set. 

from sklearn.pipeline import Pipeline
pipeline = Pipeline([
    ('bow', CountVectorizer(analyzer=text_process)),  # strings to token integer counts
    ('tfidf', TfidfTransformer()),  # integer counts to weighted TF-IDF scores
    ('classifier', MultinomialNB()),  # train on TF-IDF vectors w/ Naive Bayes classifier
])


# Now we can directly pass message text data and the pipeline will do our 
# pre-processing for us! We can treat it as a model/estimator API:
pipeline.fit(msg_train,label_train)
predictions = pipeline.predict(msg_test)
print(classification_report(predictions,label_test))

