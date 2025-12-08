from nltk.tokenize import word_tokenize, sent_tokenize

# INTRODUCTION


def read_file(filename):
    with open(filename,'r') as file:
        text = file.read()
    return text

import os
os.chdir('E:/Locker/Sai/SaiHCourseNait/DecBtch/R_Datasets/Corpora/')
text = read_file('shakespeare-taming-of-the-shrew.txt')
text[:10]
# word_tokenize - inputs ---> string containing the text
#               - outputs --> list of words


words = word_tokenize(text)
print('Size as a list: ', len(words))
print('Size as a set: ', len(set(words)))
print(words[:100])

# sent_tokenize - inputs ---> string containing the text
#               - outupts --> list of sentences

sentences = sent_tokenize(text)
print('No. of sentences: ', len(sentences),'\n')
for sentence in sentences[:5]:
    print(sentence.strip())

print('Size as a list: ', len(sentences))
print('Size as a set: ', len(set(sentences)),end='\n\n')
print(sentences[:10])