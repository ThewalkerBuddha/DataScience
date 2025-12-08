from nltk.corpus import PlaintextCorpusReader


# download plays in txt format of Shakespeare  
# http://www.textfiles.com/etext/AUTHORS/SHAKESPEARE/

import os

#corpus_root = os.getcwd() + '/'
corpus_root = 'E:/Locker/Sai/SaiHCourseNait/DecBtch/R_Datasets/Corpora'# + '/'
corpus_root 

file_ids = '.*.txt'

corpus = PlaintextCorpusReader(corpus_root, file_ids)
print(corpus.fileids())
# this will take a long time if v hv a lot of files

print(corpus.words('shakespeare-taming-of-the-shrew.txt'))