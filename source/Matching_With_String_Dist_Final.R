
library(stringdist)
library(dplyr)



OCC_Title_Match <- df_final %>%pull(OCC_TITLE)
List<-c("IT Project Manager I","IT Project Manager III","Senior Computer Security Systems Specialist",
        "Senior Security Analyst","Cloud Engineer","Senior Data Scientist","User Experience (UX) Developer",
        "Software Developer I","Software Developer III","Test Automation Engineer")


# Naive approach
#start <- proc.time()
results <- c()
for(city in List)
{
  
  best_dist <- -Inf
  for(check in OCC_Title_Match)
  {
    dist <- stringsim(city, check, method = "qgram",q=4)
    if(dist > best_dist)
    {
      closest_match <- check
      best_dist <- dist
      
    }
    
  }
  
  results <- append(results, closest_match)
  
}
#end <- proc.time()

df_legend <- df_final %>%
  select(OCC_TITLE,OCC_CODE) %>%
  distinct()


Matches <- List %>%
  bind_cols(results) %>%
  rename(Allwyn=`...1`, BLS=`...2`) %>%
  slice(c(2:7,9:10)) %>%
  left_join(df_legend,by=c("BLS"="OCC_TITLE"))

df_final <-df_final %>%
  select(OCC_TITLE,OCC_CODE,AREA,H_MEAN,A_MEAN,Year,PRIM_STATE)

df_final_matches<-Matches %>%
  left_join(df_final, by=c("OCC_CODE"="OCC_CODE"))


dupe <- df_final %>%
  group_by(OCC_TITLE,Year,PRIM_STATE,H_MEAN) %>%
  filter(n()>1)

dupe <- df_final %>%
  group_by(OCC_TITLE,AREA,Year,PRIM_STATE,H_MEAN) %>%
  filter(n()>1)
