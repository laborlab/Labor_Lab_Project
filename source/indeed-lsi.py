#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Mon Jun 28 14:21:16 2021

@author: fangxinzhang
"""

import os
os.chdir('/Users/fangxinzhang/Documents/2021 summer/DAEN 690/WEEK 5/file/indeed/LSI')
import pandas as pd
import numpy as np


# download description file#
allwyn = pd.read_excel (r'allwyn.xlsx')
print (allwyn)
OCCUP1= pd.read_excel(r'1.xls')
OCCUP2= pd.read_excel(r'2.xls')
OCCUP3= pd.read_excel(r'3.xls')
OCCUP4= pd.read_excel(r'4.xls')
OCCUP5= pd.read_excel(r'5.xls')
OCCUP6= pd.read_excel(r'6.xls')
OCCUP7= pd.read_excel(r'7.xls')
OCCUP8= pd.read_excel(r'8.xls')
OCCUP9= pd.read_excel(r'9.xls')
OCCUP10= pd.read_excel(r'10.xls')

frame=[OCCUP1,OCCUP2,OCCUP3,OCCUP4,OCCUP5,OCCUP6,OCCUP7,OCCUP8,OCCUP9,OCCUP10]
occupation=pd.concat(frame).drop_duplicates().reset_index(drop=True)
print (occupation)
occupation.size
import nltk	
nltk.download('stopwords')
from nltk.tokenize import word_tokenize
from nltk import sent_tokenize
from nltk.corpus import stopwords
stop = stopwords.words('english')

# convert to lower case
allwyn['target description'] = allwyn['target description'].str.lower()
allwyn['target description']= allwyn['target description'].apply(word_tokenize)
allwyn['target description']= allwyn['target description'].apply(lambda x:[word for word in x if word.isalnum()])
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

lsi = models.LsiModel(corpus, id2word=dictionary, num_topics=7)
index = similarities.MatrixSimilarity(lsi[corpus])


# build test document#

test= occupation['Description'].apply(word_tokenize)
# convert to lower case
occupation['Description'] = occupation['Description'].str.lower()
occupation['Description']= occupation['Description'].apply(word_tokenize)
occupation['description']= occupation['description'].apply(lambda x:[word for word in x if word.isalnum()])
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


    A0=b[:,0]
    B0= A0.argsort()[-10:][::-1]
    df0=occupation.loc[B0,:]
    
    A1=b[:,1]
    B1= A1.argsort()[-10:][::-1]
    df1=occupation.loc[B1,:]
    
    A2=b[:,2]
    B2= A2.argsort()[-10:][::-1]
    df2=occupation.loc[B2,:]
    
    A3=b[:,3]
    B3= A3.argsort()[-10:][::-1]
    df3=occupation.loc[B3,:]
    
    A4=b[:,4]
    B4= A4.argsort()[-10:][::-1]
    df4=occupation.loc[B4,:]
    
    A5=b[:,5]
    B5= A5.argsort()[-10:][::-1]
    df5=occupation.loc[B5,:]
    
    A6=b[:,6]
    B6= A6.argsort()[-10:][::-1]
    df6=occupation.loc[B6,:]
    
    A7=b[:,7]
    B7= A7.argsort()[-10:][::-1]
    df7=occupation.loc[B7,:]
    
    A8=b[:,8]
    B8= A8.argsort()[-10:][::-1]
    df8=occupation.loc[B8,:]
    
    A9=b[:,9]
    B9= A9.argsort()[-10:][::-1]
    df9=occupation.loc[B9,:]
    
   
   


#convert to dataframe#


df0.to_excel(r'1.IT1.xlsx', index = True)
df1.to_excel(r'2.IT3.xlsx', index = True)
df2.to_excel(r'3.COMPUTER SECURITY SPECIALIST.xlsx', index = True)
df3.to_excel(r'4.SECURITY ANALYST.xlsx', index = True)
df4.to_excel(r'5.CLOUD ENGINEER.xlsx', index = True)
df5.to_excel(r'6.DATA SCIENTIST.xlsx', index = True)
df6.to_excel(r'7.UX DEVELOPER.xlsx', index = True)
df7.to_excel(r'8.SOFTWARE DEVELOPER1.xlsx', index = True)
df8.to_excel(r'9.SOFTWARE DEVELOPER3.xlsx', index = True)
df9.to_excel(r'10.TEST ENGINEER.xlsx', index = True)










