
# Corpus is a collection of texts
# Corpora is a plural of corpus

#pip install nltk or conda install nltk
#nltk.dowload()
import nltk

# some names of the corpus provided in the nltk module 
# Gutenberg Corpus - import format --> nltk.corpus.gutenberg
# Web and Chat Text - import format --> nltk.corpus.webtext
# NPS Chat - import format --> nltk.corpus.nps_chat
# Brown Corpus - import format --> nltk.corpus.brown
# Reuters Corpus - import format --> nltk.corpus.reuters
# Inaugural Address Corpus - import format --> nltk.corpus.inaugural

from nltk.corpus import gutenberg as gt
print(gt.fileids())
# gvs all the files that the corpus has


# words func
shkspr_hmlt = gt.words('shakespeare-hamlet.txt')
print(shkspr_hmlt,end='\n\n\n')
# gvs all the words

print(len(shkspr_hmlt))

shkspr_hmlt = gt.raw('shakespeare-hamlet.txt')
print(shkspr_hmlt,end='\n\n\n')
# gvs the raw text

# functions - raw() - words() - sents()

for fileid in gt.fileids():
    #raw_data = gt.raw(fileid)
    num_words = len(gt.words(fileid))
    num_sents = len(gt.sents(fileid))
    #vocabulary = set([w.lower() for w in gt.words(fileid)])
    print('Data for File Id :',fileid)
    print('Number of words:',num_words,'\nNumber of sentences:',num_sents)
    #print('Vocabulary:\n',vocabulary,end='\n\n\n')
    print('Words :', gt.words(fileid), end='\n\n\n')
