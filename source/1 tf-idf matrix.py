#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Thu Jun 10 19:06:45 2021

@author: fangxinzhang
"""

# -*- coding: utf-8 -*-
"""
Spyder Editor

This is a temporary script file. 
"""
#et path and api#
import os
os.chdir('/Users/fangxinzhang/Documents/2021 summer/DAEN 690/week 4/python/file')
#pip install git+https://github.com/pdftables/python-pdftables-api.git
#pdftables_api.Client('j6yzvexojr7k').csv(/Users/fangxinzhang/Documents/2021 summer/DAEN 690/week 4/python/file,/Users/fangxinzhang/Documents/2021 summer/DAEN 690/week 4/python/file)

# Import Module
#import pdftables_api
# API KEY VERIFICATION
#conversion = pdftables_api.Client('j6yzvexojr7k')
#os.chdir('/Users/fangxinzhang/Documents/2021 summer/DAEN 690/week 4/python/file')
# PDf to CSV
#conversion.csv('allwyn.PDF','allwyn.csv')#


import pandas as pd
import numpy as np

# download description file#
allwyn = pd.read_excel (r'allwyn.xlsx')
print (allwyn)
occupation = pd.read_excel (r'Occupation Data.xlsx')
print (occupation)



occupation ['Description'] = occupation ['Description'].str.lower()
#convert to dictionary#
#allwyn_dic=allwyn.set_index('target job category').T.to_dict('list')
#occupation_dic=occupation.set_index('Title').T.to_dict('list')




pip install --upgrade gensim
from gensim.test.utils import common_corpus, common_dictionary, get_tmpfile
from gensim.similarities import Similarity
from gensim.corpora.textcorpus import TextCorpus
from gensim.corpora import Dictionary
from gensim.models import TfidfModel
import gensim

#gensim#
#step1-2#
from nltk.tokenize import word_tokenize
import nltk

#lower#
allwyn['target description'] = allwyn['target description'].str.lower()
#convert to string#
allwyn['target description'] = allwyn['target description'].astype(str)
#dropna#
allwyn['target description'].dropna(inplace=True)
#split to words#
gen_docs= allwyn['target description'].apply(word_tokenize)
#convert to list#
#allwyn_list = df.values.tolist()#


nltk.download('punkt')
raw_documents = gen_docs
print("Number of documents:",len(raw_documents))
print(gen_docs)

#build dictionary#
dictionary = Dictionary(gen_docs)
print(dictionary[5])
print(dictionary.token2id['project'])
print("Number of words in dictionary:",len(dictionary))

for i in range(len(dictionary)):
    print(i, dictionary[i])


#step 4 build corpus#
corpus = [dictionary.doc2bow(gen_doc) for gen_doc in gen_docs]
print(corpus)

#step 5 tf-idf modeling#

tf_idf = TfidfModel(corpus)
print(tf_idf)

#step 6 similarity comparing#
sims = gensim.similarities.Similarity('./',tf_idf[corpus],num_features=len(dictionary))
print(sims)
print(type(sims))

# build test document#

test= occupation['Description'].apply(word_tokenize)

query_doc =test
print(query_doc)
query_doc=query_doc.to_frame()

#loop here#
  query_doc_bow= [dictionary.doc2bow(content)for content in query_doc]
print(query_doc_bow)

query_doc_tf_idf= [tf_idf[index]for index in query_doc_bow]
print(query_doc_tf_idf)


a=sims[query_doc_tf_idf]





