# I frequently visit bakery. A frequent word.
# Generally frequent is more used as an adjective than a verb
# Assign 1 tag to 1 word is unigram tagging
# How does it internally do it
# V need to train it
# V can use brown corpus for training
# 


# this is a tagged corpora
brown_tagged_sents = brown.tagged_sents(categories='news')
# this is untagged corpora
brown_sents = brown.sents(categories='news')

unigram_tagger = nltk.UnigramTagger(brown_tagged_sents)
# this is where v r training it as v r passing sents to it

print(unigram_tagger.tag(nltk.word_tokenize('I am studying NLP')))
# NLP is None mean 
# it has no match in training dataset

# evaluation function -- evaluate()
print(unigram_tagger.evaluate(brown_tagged_sents))
# this gvs accuracy

# Separate training & testing dataset
size = int(len(brown_tagged_sents)*0.9)
training_set = brown_tagged_sents[:size]
training_set 

testing_set = brown_tagged_sents[size:]

unigram_tagger = nltk.UnigramTagger(training_set)
print(unigram_tagger.evaluate(testing_set))
# 81% acc, scope for improvement


