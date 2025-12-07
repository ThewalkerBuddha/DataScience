
tags = [tag for (word, tag) in brown.tagged_words(categories='news')]
print(set(tags))
print(nltk.FreqDist(tags).max())
# FreqDist is same as WC


raw_text = 'We are learning taggers right now and aim to build applications which uses language to perform analysis'

tokens = nltk.word_tokenize(raw_text)

default_tagger = nltk.DefaultTagger(nltk.FreqDist(tags).max())
print(default_tagger.tag(tokens))
# it tags everything as same which is max
# this is not always right
# this is poor 
# v can train our taggers to do better

