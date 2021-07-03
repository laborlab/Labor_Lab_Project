library(tidyverse)
library(ggplot2)
library(lubridate)
df_group_by_year_job <- df_final_matches%>%
  # mutate_at(vars(H_MEAN), as.factor) %>%
  mutate_at(vars(H_MEAN), as.numeric) %>%
  group_by(Allwyn,Year) %>%
  # mutate_at(vars(Year), as.factor) %>%
  summarise(mean_of_mean= mean(H_MEAN, na.rm = TRUE)) %>%
  mutate(Date=make_date(Year,month = 1L, day=1L)) %>%
  select(-Year)

df_cloud_eng <- df_group_by_year_job %>%
  filter(Allwyn =="Cloud Engineer") %>%
  select(- c("Allwyn"))
  # arrange(Year) %>%
  # select(mean_of_mean) %>%
  # ts(start = 2010)


df_cloud_eng <- df_group_by_year_job %>%
  filter(Allwyn =="Cloud Engineer") %>%
  arrange(Year) %>%
  select(mean_of_mean) %>%
  ts(start = 2010)

autoplot(df_cloud_eng$mean_of_mean)

class(df_cloud_eng)

qplot(mean_of_mean, data = as.data.frame(df_cloud_eng))
