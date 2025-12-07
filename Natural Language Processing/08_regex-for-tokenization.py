#import re

text = 'A Linux server, like any other computer you may be familiar with, runs applications. To the computer, these are' \
       ' considered "processes" While Linux will handle the low-level, behind-the-scenes management in a process\'s ' \
       'life-cycle, you will need a way of interacting with the operating system to manage it from a higher-level.'
print(re.split(' ', text))
# ntc last word higher-level.
# splits based on a WS char includes puncts

print(re.split('\s+', text))
# same as above recomended than the abv

print(re.split('\W', text)) 
# ntc punctuations r not taken as tokens and not present

print(re.findall('\w+|\S|\w*', text))
# punctuations r taken as tokens 
 
print(re.findall("\w+[-']+\w+", text))
# all the wrds which contain - or ' (apostrophe)


