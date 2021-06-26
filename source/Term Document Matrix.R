library(tm)
library(slam)


string.corpus <- Corpus(VectorSource(List))

TD.stromg <- TermDocumentMatrix(string.corpus, control = list(
  wordLenghts=c(1,Inf), weigthing= function(x)
    weightTfIdf(x, normalize =
                  FALSE),
  stopwords = FALSE))

inspect(TD.stromg)

TD.stromg <- TermDocumentMatrix(string.corpus, control = list(
  global=c(1,Inf), weighting= weightTfIdf))
