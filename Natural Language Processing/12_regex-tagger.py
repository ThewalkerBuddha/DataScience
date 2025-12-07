
patterns = [(r'.*ing$', 'VBG'), (r'.*ed$', 'VBD'), (r'.*es$', 'VBZ'), (r'.*ould$', 'MD'), (r'.*\'s$', 'NN$'),
             (r'.*s$', 'NNS'),  (r'^-?[0-9]+(.[0-9]+)?$', 'CD'), (r'.*', 'NN')]
# a list of tuples with regex pattern and tagger
sample = 'I am playing football'

regexp_tagger = nltk.RegexpTagger(patterns)

print(regexp_tagger.tag(nltk.word_tokenize(sample)))


patterns = [(r'.*', 'NN')]
sample = 'I am playing football'
regexp_tagger = nltk.RegexpTagger(patterns)
print(regexp_tagger.tag(nltk.word_tokenize(sample)))



patterns = [(r'.*ing$', 'VBG'), (r'.*', 'NN')]
sample = 'I am playing football'
regexp_tagger = nltk.RegexpTagger(patterns)
print(regexp_tagger.tag(nltk.word_tokenize(sample)))


# this is time consuming
patterns = [(r'.*ing$', 'VBG'), (r'.*ed$', 'VBD'), (r'.*es$', 'VBZ'), (r'.*ould$', 'MD'), (r'.*\'s$', 'NN$'),
             (r'.*s$', 'NNS'),  (r'^-?[0-9]+(.[0-9]+)?$', 'CD'), (r'.*', 'NN')]
regexp_tagger = nltk.RegexpTagger(patterns)
print(regexp_tagger.tag(nltk.corpus.brown.words()))
