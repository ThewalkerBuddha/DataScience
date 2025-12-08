import re

# search function

if((re.search('^a','abc'))):
	print('Found it !')

re.search('^a','abc')

re.search('^a','Abc')

if((re.search('^a','Abc'))):
	print('Found it !')
else:
	print('Not found')

#get all words which end with ed

wrds_ndng_wth_ed = [w for w in words if re.search('ed$',w)]
print(len(wrds_ndng_wth_ed))
print(len(set(wrds_ndng_wth_ed)))
print(wrds_ndng_wth_ed)

wrds_ndng_wth_er = [w for w in words if re.search('ner$',str(w).lower())]
print(len(wrds_ndng_wth_er))
print(len(set(wrds_ndng_wth_er)))
print(wrds_ndng_wth_er)

# ranges and closures
# *, +
# a* is 0 or many times
# a+ is 1 or many times

print(len(set([w for w in words if re.search('^a*',w)])))
print(set([w for w in words if re.search('^a*',w)]))

print(len(set([w for w in words if re.search('^a+',w)])))
print(set([w for w in words if re.search('^a+',w)]))

print([w for w in words if re.search('^at*',w)])

