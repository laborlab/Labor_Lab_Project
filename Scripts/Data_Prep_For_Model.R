library(tidyverse)
library(ggplot2)
library(fpp2)
library(lubridate)
library(DT)

df_group_by_year_job <- df_final_matches%>%
  # mutate_at(vars(H_MEAN), as.factor) %>%
  mutate_at(vars(H_MEAN), as.numeric) %>%
  group_by(Allwyn,Year) %>%
  # mutate_at(vars(Year), as.factor) %>%
  summarise(mean_of_mean= mean(H_MEAN, na.rm = TRUE)) %>%
  mutate(Date=make_date(Year,month = 1L, day=1L)) %>%
  select(-Year) %>%
  arrange(Date) %>%
  ungroup()

df_cloud_eng <- df_group_by_year_job %>%
  filter(Allwyn =="Cloud Engineer") %>%
  select(-Allwyn)


ts_cloud_eng<- ts(df_cloud_eng$mean_of_mean,start = 2010)



autoplot(ts_cloud_eng)




cloud_eng_fit_meanf <- meanf(ts_cloud_eng, h=5, level=10)

plot(cloud_eng_fit_meanf, main="Naive Mean Forcast", ylab = "Hourly Wage", xlab = "Year")


cloud_eng_fit_snaive <- snaive(ts_cloud_eng, h=5, level=10)

plot(cloud_eng_fit_snaive, main=" Season Naive Forcast", ylab = "Hourly Wage", xlab = "Year")



cloud_eng_fit_rwf <- rwf(ts_cloud_eng, h=5,drift = TRUE ,level=10)

plot(cloud_eng_fit_rwf, main="Drift Method", ylab = "Hourly Wage", xlab = "Year")


####
autoplot(ts_cloud_eng) +
  autolayer(snaive(ts_cloud_eng, h=5, level=0),
            series="snaive", PI=FALSE) +
  autolayer(rwf(ts_cloud_eng, h=5,level=0),
               series="drift", PI=FALSE)

####

ses_cloud_eng <-ses(ts_cloud_eng, h=5)

ses_cloud_eng$fitted

round(accuracy(ses_cloud_eng),2)

ts_cloud_eng
ses_cloud_eng$fitted

#model plots

autoplot(ses_cloud_eng)+
  autolayer(fitted(ses_cloud_eng, h=5), series="Fitted") +
  ylab("Hourly Wage")+ xlab("Year") +
  ggtitle("Exponential Smoothing") +
  theme_minimal()


autoplot(ts_cloud_eng)+
  autolayer(fitted(ses_cloud_eng, h=5), series="Fitted") +
  ylab("Hourly Wage")+ xlab("Year") +
  ggtitle("Exponential Smoothing") +
  theme_minimal()

plot(ses_cloud_eng)

#?meanf


#####Forcast Table
holt_cloud_eng <-holt(ts_cloud_eng, h=5, level = 10)
summary(holt_cloud_eng) %>% 
  datatable() %>%
  DT::formatRound(c("Point Forecast","Lo 80", "Hi 80", "Lo 95", "Hi 95"), digits = 2)


autoplot(ts_cloud_eng)+
  autolayer(holt_cloud_eng, series="Projection") +
  autolayer(fitted(holt_cloud_eng), series="Fitted") +
  ylab("Hourly Wage")+ xlab("Year") +
  ggtitle("Exponential Smoothing") +
  theme_minimal()



holt_cloud_eng_d <-holt(ts_cloud_eng,damped = TRUE ,h=5)
summary(holt_cloud_eng_d)


round(accuracy(holt_cloud_eng_d),2) %>% datatable()
