# Introduction to tagger
# POS Tagging is used for analysing the context
# Then get all the words which are used in the same context

text = 'We are learning Natural Languages Processing'

tokens = nltk.word_tokenize(text)
print(nltk.pos_tag(tokens))

# what is pos_tag function returning ?
# Guide to each tag

print(nltk.help.upenn_tagset('PRP'))

print(nltk.help.upenn_tagset('VBP'))

# similar method of text
text = nltk.Text(word.lower() for word in nltk.corpus.brown.words())

print(text.similar('woman'))
'''
These r the words which appear in same context of woman
It goes thru all the words
then labels it
then finds the context or parts of speech
then find all the words with same pos or context

man time day year car moment world house family child country boy
state job place way war girl work word
'''
print(nltk.pos_tag(['woman']))

print(nltk.help.upenn_tagset('NN'))

print(text.similar('bought'))
