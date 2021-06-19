
library(stringdist)
library(dplyr)



OCC_Title_Match <- df_final %>%pull(OCC_TITLE)
List<-c("IT Project Manager I","IT Project Manager III","Senior Computer Security Systems Specialist",
        "Senior Security Analyst","Cloud Engineer","Senior Data Scientist","User Experience (UX) Developer",
        "Software Developer I","Software Developer III","Test Automation Engineer ")


# Naive approach
start <- proc.time()
results <- c()
for(city in List)
{
  
  best_dist <- -Inf
  for(check in OCC_Title_Match)
  {
    dist <- stringsim(city, check, method = "jw")
    if(dist > best_dist)
    {
      closest_match <- check
      best_dist <- dist
      
    }
    
  }
  
  results <- append(results, closest_match)
  
}
end <- proc.time()

Matches <- List %>%
  bind_cols(results) %>%
  rename(Allwyn=`...1`, BLS=`...2`)
