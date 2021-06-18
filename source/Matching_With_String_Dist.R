#Testing simple algorythm

library(stringdist)
library(dplyr)



OCC_Title_Match <- df_final %>%pull(OCC_TITLE)
List<-c("IT Project Manager I","IT Project Manager III","Senior Computer Security Systems Specialist",
        "Senior Security Analyst","Cloud Engineer","Senior Data Scientist","User Experience (UX) Developer",
        "Software Developer I","Software Developer III","Test Automation Engineer ")

# define function to search for best string match in cities
get_best_match <- function(city, cities = cities)
{
  
  max_index <- which.max(stringsim(city, cities, method = "qgram"))
  
  return(cities[max_index])
  
}


vector_start <- proc.time()
vector_results <- sapply(List, function(city) get_best_match(List, OCC_Title_Match))
vector_end <- proc.time()


vector_results<- as.data.frame(vector_results)





stringdist_left_join(List,OCC_Title_Match)
?stringsim

test<- stringsimmatrix(List, OCC_Title_Match, method = "jw")

t<-transpose(test)
