#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Fri Jun 18 12:32:05 2021

@author: fangxinzhang
"""

import os
os.chdir('/Users/fangxinzhang/Documents/2021 summer/DAEN 690/week 4/python/file')
import pandas as pd
import numpy as np


# download description file#
allwyn = pd.read_excel (r'allwyn.xlsx')
print (allwyn)
occupation = pd.read_excel (r'Occupation Data.xlsx')
print (occupation)

import nltk	
nltk.download('stopwords')
from nltk.tokenize import word_tokenize
from nltk import sent_tokenize
from nltk.corpus import stopwords
stop = stopwords.words('english')

# convert to lower case
allwyn['target description'] = allwyn['target description'].str.lower()
allwyn['target description']= allwyn['target description'].apply(word_tokenize)
allwyn['target description'].dropna(inplace=True)
allwyn['target description']=allwyn['target description'].apply(lambda x: [item for item in x if item not in stop])

from nltk.stem.snowball import SnowballStemmer

# Use English stemmer.
stemmer = SnowballStemmer("english")
allwyn['target description']=allwyn['target description'].apply(lambda x: [stemmer.stem(y) for y in x])
allwyn['target description'].dropna(inplace=True)
gen_docs= allwyn['target description']



pip install --upgrade gensim
from gensim.test.utils import common_corpus, common_dictionary, get_tmpfile
from gensim.similarities import Similarity
from gensim.corpora.textcorpus import TextCorpus
from gensim.corpora import Dictionary
from gensim.models import TfidfModel
from gensim.models import word2vec
from gensim.models import rpmodel
from gensim.models import ldamodel
from gensim.models import hdpmodel
import gensim
from gensim import corpora, models, similarities

#gensim#
#step1-2#
from nltk.tokenize import word_tokenize
import nltk
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

lsi = models.LsiModel(corpus, id2word=dictionary, num_topics=20)
index = similarities.MatrixSimilarity(lsi[corpus])


# build test document#

test= occupation['Description'].apply(word_tokenize)
# convert to lower case
occupation['Description'] = occupation['Description'].str.lower()
occupation['Description']= occupation['Description'].apply(word_tokenize)
occupation['Description'].dropna(inplace=True)
occupation['Description']=occupation['Description'].apply(lambda x: [item for item in x if item not in stop])
occupation['Description']=occupation['Description'].apply(lambda x: [stemmer.stem(y) for y in x])
occupation['Description'].dropna(inplace=True)
test= occupation['Description']


query_doc =test
print(query_doc)
#query_doc=query_doc.to_frame()

#loop here#
  query_doc_bow= [dictionary.doc2bow(content)for content in query_doc]
print(query_doc_bow)

query_doc_lsi= [lsi[i]for i in query_doc_bow]
print(query_doc_lsi)

b=index[query_doc_lsi]

#convert to dataframe#

dflsi2 = pd.DataFrame(b, columns = allwyn['target job category'], index=occupation['Title'])

dflsi2.to_excel(r'lsi2.xlsx', index = True)


