from nltk import PorterStemmer, LancasterStemmer

#tokens = nltk.corpus.brown.words(categories=['romance'])
# off the shelf stemmers
# The Porter Stemmer is a good choice if you are indexing some texts and 
# want to support search using alternative forms of words
# crying --> cry

#Stemming does not do a dictionary lookup but lemmatization does
porter = PorterStemmer()
# stem() function - takes a token as input
tokens = ['lying']
print(porter.stem(tokens[0]))


lancaster = LancasterStemmer()
print(lancaster.stem(tokens[0]))

#print([porter.stem(t) for t in tokens])
#print([lancaster.stem(t) for t in tokens])