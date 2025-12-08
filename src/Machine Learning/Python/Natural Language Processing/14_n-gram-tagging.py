# Unigram is not v efficient not accurate
# Ngram gvs higher accuracy

# I don't know what to say
# 1-gram is --> I, don't, know, what, to, say
# 2-gram is --> I don't, don't know, know what, what to, to say
# 3-gram is --> I don't know, don't know what, know what to, what to say
# ...
# Concept of N-Gram tagging
# Assign 1 tag to word based on context of word occurence with prev words is ngram tagging
# say know is first appearing as verb 1 time and 2 times as ADJ in its previous contexts
# it assigns it as ADJ

tagger = nltk.NgramTagger(4,train=brown_tagged_sents)
print(tagger.tag(nltk.word_tokenize('We are studying NLP')))
# studying is a data point which is not in the training

tagger = nltk.NgramTagger(1,train=brown_tagged_sents)
print(tagger.tag(nltk.word_tokenize('We are studying NLP')))

# tagged sentences
brown_tagged_sents = brown.tagged_sents(categories='news')
# untagged sentences
brown_sents = brown.sents(categories='news')
#print(brown_sents)
#print(brown_tagged_sents)

tagger = nltk.NgramTagger(len(brown_tagged_sents),train=brown_tagged_sents)
print(tagger.tag(nltk.word_tokenize('We are using the programming language Python')))

