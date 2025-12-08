from nltk import WordNetLemmatizer
from nltk.corpus import brown
#import nltk

# Difference between stemming and lemmatization
#Stemming does not do a dictionary lookup but lemmatization does
# v r normalizing the words as v cannot do every word v use Lemma
tokens = brown.words(categories=['religion'])
wnl = WordNetLemmatizer()
print(set([wnl.lemmatize(t) for t in tokens]))

# The WordNet lemmatizer only removes affixes if the resulting word is in its dictionary
# It is a good choice if you want to compile the vocabulary of some texts and want a list of valid lemmas
tokens = nltk.word_tokenize('the women are not lying') # women --> woman
print([wnl.lemmatize(t) for t in tokens])

# converted women to woman but was unable to convert lying to lie
