from nltk.corpus import gutenberg, brown, nps_chat
#import nltk

moby = nltk.Text(gutenberg.words('melville-moby_dick.txt'))
print(moby.findall(r'<a><.*><man>'))
# a ___ man # 3 tokens each word is a token


#Creating a Text object
chat_obj = nltk.Text(nps_chat.words())
print(chat_obj.findall(r'<.*><.*><bro>'))

hobbies_learned = nltk.Text(brown.words(categories=['hobbies', 'learned']))
print(hobbies_learned.findall(r'<\w*><and><other><\w*s>'))


# passing your own list of words
text = 'Hello, I am an electrical engineer who is currently learning Data Science and studying NLP !'

obj = nltk.Text(nltk.word_tokenize(text))
print(obj.findall(r'<.*ing>+'))
