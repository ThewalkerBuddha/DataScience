sample = 'my name is ABC. I work at xyz'
# if v want all the words in the context of ABC
# v need to do 2 steps
# first create a Text object
# second call the similar method using the pos or context
# but this is memory consuming
# so v can perform tagging only once and reuse it

word = 'AUSTRALIA/NNP'
tagged_token = nltk.tag.str2tuple(word)
# converts a str to a tuple
print(tagged_token)
# By this v can gv our sys a predefined sample of tags & words
# and reuse them and save processing time

tagged_token = nltk.tag.str2tuple('fly/NN')
print(tagged_token)

for word,tag  in nltk.corpus.brown.tagged_words(categories='news')[:20]:
	print(word,'    ', tag)
# What does this mean?
# brown corpus is already tagged so v can minimize the proc time
# on operations


# This is a tagged sent
sentence = '''
The/AT grand/JJ jury/NN commented/VBD on/IN a/AT number/NN of/IN
... other/AP topics/NNS ,/, AMONG/IN them/PPO the/AT Atlanta/NP and/CC
... Fulton/NP-tl County/NN-tl purchasing/VBG departments/NNS which/WDT it/PPS
... said/VBD ``/`` ARE/BER well/QL operated/VBN and/CC follow/VB generally/RB
... accepted/VBN practices/NNS which/WDT inure/VB to/IN the/AT best/JJT
... interest/NN of/IN both/ABX governments/NNS ''/'' ./.
'''
print([nltk.tag.str2tuple(token) for token in sentence.split()])

