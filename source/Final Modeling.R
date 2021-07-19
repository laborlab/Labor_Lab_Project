library(tidyverse)
library(dplyr)
library(data.table)
library(lubridate)
library(fpp2)
library(stringr)
library(DT)

setwd("C:/Users/willi/OneDrive/Desktop/Labor_Lab_Project/data/Final")

df_final_matches <-read.csv("BLS_merged-New.csv")

# c("Cloud Engineer","IT Project Manager",
#   "Senior Computer Security Systems Specialist","Senior Security Analyst",
#   "Senior Data Scientist","User Experience (UX) Developer","	Software Developer",
#   "Test Automation Engineer")

df_group_by_year_job <- df_final_matches%>%
  # mutate_at(vars(H_MEAN), as.factor) %>%
  mutate_at(vars(H_MEAN), as.numeric) %>%
  group_by(OCC_TITLE,Year) %>%
  # mutate_at(vars(Year), as.factor) %>%
  summarise(mean_of_mean= mean(H_MEAN, na.rm = TRUE)) %>%
  mutate(Date=make_date(Year,month = 1L, day=1L)) %>%
  select(-Year) %>%
  arrange(Date) %>%
  ungroup()


#IT Project Manager

df_IT_Project <- df_group_by_year_job %>%
  filter(OCC_TITLE=="Computer and Information Systems Managers") %>%
  select(-OCC_TITLE)

df_IT_Project<- ts(df_IT_Project$mean_of_mean,start = 2010)


#####Forcast Table
holt_IT_Project <-holt(df_IT_Project, h=7, level = 90)
summary(holt_IT_Project) %>% 
  datatable(caption = "IT Project Manager") %>%
  DT::formatRound(c("Point Forecast","Lo 90", "Hi 90"), digits = 2)


autoplot(df_IT_Project)+
  autolayer(holt_IT_Project, series="Projection") +
  autolayer(fitted(holt_IT_Project), series="Fitted") +
  ylab("Hourly Wage")+ xlab("Year") +
  ggtitle("Exponential Smoothing IT Project Management") +
  theme_minimal()



holt_IT_Project <-holt(df_IT_Project ,h=7)
summary(holt_IT_Project)


round(accuracy(holt_IT_Project),2) %>% datatable(caption = "IT Project Manager Errors")

holt_IT_Project$model$par %>%
  as.data.frame %>%
  datatable(caption = "IT Project Manager Coefficients") %>%
  formatRound(c(1),digits = 2)



#######Senior Data Scientist



df_data_scientist <- df_group_by_year_job %>%
  filter(OCC_TITLE=="Computer and Information Research Scientists") %>%
  select(-OCC_TITLE)

df_data_scientist<- ts(df_data_scientist$mean_of_mean,start = 2010)


#####Forcast Table
holt_data_scient <-holt(df_data_scientist, h=7, level = 90)
summary(holt_data_scient) %>% 
  datatable(caption = "Senior Data Scientist") %>%
  DT::formatRound(c("Point Forecast","Lo 90", "Hi 90"), digits = 2)


autoplot(df_data_scientist)+
  autolayer(holt_data_scient, series="Projection") +
  autolayer(fitted(holt_data_scient), series="Fitted") +
  ylab("Hourly Wage")+ xlab("Year") +
  ggtitle("Exponential Smoothing Data Scientist") +
  theme_minimal()



holt_data_scient <-holt(holt_data_scient ,h=7)
summary(holt_data_scient)


round(accuracy(holt_data_scient),2) %>% datatable(caption = "Senior Data Scientist Errors")


holt_data_scient$model$par %>%
  as.data.frame %>%
  datatable(caption = "Senior Data Scientist Coefficients") %>%
  formatRound(c(1),digits = 6)









#######Cloud Engineer


df_cloud_eng <- df_group_by_year_job %>%
  filter(OCC_TITLE=="Computer Hardware Engineers") %>%
  select(-OCC_TITLE)

df_cloud_eng<- ts(df_cloud_eng$mean_of_mean,start = 2010)


#####Forcast Table
holt_cloud_eng <-holt(df_cloud_eng, h=7, level = 90)
summary(holt_cloud_eng) %>% 
  datatable(caption = "Cloud Engineer") %>%
  DT::formatRound(c("Point Forecast","Lo 90", "Hi 90"), digits = 2)


autoplot(df_cloud_eng)+
  autolayer(holt_cloud_eng, series="Projection") +
  autolayer(fitted(holt_cloud_eng), series="Fitted") +
  ylab("Hourly Wage")+ xlab("Year") +
  ggtitle("Exponential Smoothing Cloud Engineer") +
  theme_minimal()



holt_cloud_eng <-holt(df_cloud_eng, h=7)
summary(holt_cloud_eng)


round(accuracy(holt_cloud_eng),2) %>% datatable(caption = "Cloud Engineer Errors")


holt_cloud_eng$model$par %>%
  as.data.frame %>%
  datatable(caption = "Cloud Engineer Coefficients") %>%
  formatRound(c(1),digits = 6)






#######Senior Security Analyst


df_Secu_Sec <- df_group_by_year_job %>%
  filter(OCC_TITLE=="Information Security Analysts") %>%
  select(-OCC_TITLE)

df_Secu_Sec<- ts(df_Secu_Sec$mean_of_mean,start = 2012)


#####Forcast Table
holt_Secu_Sec <-holt(df_Secu_Sec, h=7, level = 90)
summary(holt_Secu_Sec) %>% 
  datatable(caption = "Senior Security Analyst") %>%
  DT::formatRound(c("Point Forecast","Lo 90", "Hi 90"), digits = 2)


autoplot(df_Secu_Sec)+
  autolayer(holt_Secu_Sec, series="Projection") +
  autolayer(fitted(holt_Secu_Sec), series="Fitted") +
  ylab("Hourly Wage")+ xlab("Year") +
  ggtitle("Exponential Smoothing Senior Security Analyst") +
  theme_minimal()



holt_Secu_Sec <-holt(holt_Secu_Sec ,h=7)
summary(holt_Secu_Sec)


round(accuracy(holt_Secu_Sec),2) %>% datatable(caption = "Senior Security Analyst Errors")

holt_Secu_Sec$model$par %>%
  as.data.frame %>%
  datatable(caption = "Senior Security Analyst") %>%
  formatRound(c(1),digits = 2)











#######User Experience (UX) Developer


df_Ex_Dev <- df_group_by_year_job %>%
  filter(OCC_TITLE=="Web Developers") %>%
  select(-OCC_TITLE)

df_Ex_Dev <- ts(df_Ex_Dev$mean_of_mean,start = 2012)


#####Forcast Table
holt_Ex_Dev <-holt(df_Ex_Dev, h=7, level = 90)
summary(holt_Ex_Dev) %>% 
  datatable(caption = "User Experience (UX) Developer") %>%
  DT::formatRound(c("Point Forecast","Lo 90", "Hi 90"), digits = 2)


autoplot(df_Ex_Dev)+
  autolayer(holt_Ex_Dev, series="Projection") +
  autolayer(fitted(holt_Ex_Dev), series="Fitted") +
  ylab("Hourly Wage")+ xlab("Year") +
  ggtitle("Exponential Smoothing User Experience (UX) Developer") +
  theme_minimal()



holt_Ex_Dev <-holt(holt_Ex_Dev ,h=7)
summary(holt_Ex_Dev)


round(accuracy(holt_Ex_Dev),2) %>% datatable(caption = "User Experience (UX) Developer Errors")


holt_Ex_Dev$model$par %>%
  as.data.frame %>%
  datatable(caption = "User Experience (UX) Developer") %>%
  formatRound(c(1),digits = 2)















#######Software Developer


df_Sof_Dev <- df_group_by_year_job %>%
  filter(OCC_TITLE=="Software Developers, Applications") %>%
  select(-OCC_TITLE)

df_Sof_Dev <- ts(df_Sof_Dev$mean_of_mean,start = 2010)


#####Forcast Table
holt_Sof_Dev <-holt(df_Sof_Dev, h=8, level = 90)
summary(holt_Sof_Dev) %>% 
  datatable(caption = "Software Developer") %>%
  DT::formatRound(c("Point Forecast","Lo 90", "Hi 90"), digits = 2)


autoplot(df_Sof_Dev)+
  autolayer(holt_Sof_Dev, series="Projection") +
  autolayer(fitted(holt_Sof_Dev), series="Fitted") +
  ylab("Hourly Wage")+ xlab("Year") +
  ggtitle("Exponential Smoothing Software Developer") +
  theme_minimal()



holt_Sof_Dev <-holt(holt_Sof_Dev ,h=8)
summary(holt_Sof_Dev)


round(accuracy(holt_Sof_Dev),2) %>% datatable(caption = "Software Developer Errors")

holt_Sof_Dev$model$par %>%
  as.data.frame %>%
  datatable(caption = "Software Developer") %>%
  formatRound(c(1),digits = 6)








###############Senior Computer Security Systems Specialist

df_Comp_Syst <- df_group_by_year_job %>%
  filter(OCC_TITLE=="Computer User Support Specialists") %>%
  select(-OCC_TITLE)

df_Comp_Syst<- ts(df_Comp_Syst$mean_of_mean,start = 2010)


#####Forcast Table
holt_Comp_Syst <-holt(df_Comp_Syst, h=7, level = 90)
summary(holt_Comp_Syst) %>% 
  datatable(caption = "Senior Computer Security Systems Specialist") %>%
  DT::formatRound(c("Point Forecast","Lo 90", "Hi 90"), digits = 2)


autoplot(df_Comp_Syst)+
  autolayer(holt_Comp_Syst, series="Projection") +
  autolayer(fitted(holt_Comp_Syst), series="Fitted") +
  ylab("Hourly Wage")+ xlab("Year") +
  ggtitle("Exponential Smoothing Senior Computer Security Systems Specialist") +
  theme_minimal()



holt_Comp_Syst <-holt(holt_Comp_Syst,damped = TRUE ,h=7)
summary(holt_Comp_Syst)


round(accuracy(holt_Comp_Syst),2) %>% datatable(caption = "Senior Computer Security Systems Specialist Errors")

holt_Comp_Syst$model$par %>%
  as.data.frame %>%
  datatable(caption = "Senior Computer Security Systems Specialist Coefficients") %>%
  formatRound(c(1),digits = 2)










###########IT Project Manager III


df_group_by_year_job_two <- df_final_matches%>%
  # mutate_at(vars(H_MEAN), as.factor) %>%
  mutate_at(vars(H_PCT90), as.numeric) %>%
  group_by(OCC_TITLE,Year) %>%
  # mutate_at(vars(Year), as.factor) %>%
  summarise(mean_of_mean= mean(H_PCT90, na.rm = TRUE)) %>%
  mutate(Date=make_date(Year,month = 1L, day=1L)) %>%
  select(-Year) %>%
  arrange(Date) %>%
  ungroup()



###############IT Project Manager III

df_IT_Project_MaIII <- df_group_by_year_job_two %>%
  filter(OCC_TITLE=="Computer and Information Systems Managers") %>%
  select(-OCC_TITLE)

df_IT_Project_MaIII <- ts(df_IT_Project_MaIII$mean_of_mean,start = 2010)


#####Forcast Table
holt_IT_Project_MaIII <-holt(df_IT_Project_MaIII, h=7, level =90)
summary(holt_IT_Project_MaIII) %>% 
  datatable(caption = "IT Project Manager III") %>%
  DT::formatRound(c("Point Forecast","Lo 90", "Hi 90"), digits = 2)


autoplot(df_IT_Project_MaIII)+
  autolayer(holt_IT_Project_MaIII, series="Projection") +
  autolayer(fitted(holt_IT_Project_MaIII), series="Fitted") +
  ylab("Hourly Wage")+ xlab("Year") +
  ggtitle("Exponential Smoothing IT Project Manager III") +
  theme_minimal()



holt_IT_Project_MaIII <-holt(holt_IT_Project_MaIII ,h=7)
summary(holt_IT_Project_MaIII)


round(accuracy(holt_IT_Project_MaIII),2) %>% datatable(caption = "IT Project Manager III Errors")

holt_IT_Project_MaIII$model$par %>%
  as.data.frame %>%
  datatable(caption = "IT Project Manager III Coefficients") %>%
  formatRound(c(1),digits = 7)


















###############Sofware Developer III

df_Sof_Dev_III <- df_group_by_year_job_two %>%
  filter(OCC_TITLE=="Software Developers, Applications") %>%
  select(-OCC_TITLE)

df_Sof_Dev_III <- ts(df_Sof_Dev_III$mean_of_mean,start = 2010)


#####Forcast Table
holt_Sof_Dev_III <-holt(df_Sof_Dev_III, h=7, level = 90)
summary(holt_Sof_Dev_III) %>% 
  datatable(caption = "Sofware Developer III") %>%
  DT::formatRound(c("Point Forecast","Lo 90", "Hi 90"), digits = 2)


autoplot(df_Sof_Dev_III)+
  autolayer(holt_Sof_Dev_III, series="Projection") +
  autolayer(fitted(holt_Sof_Dev_III), series="Fitted") +
  ylab("Hourly Wage")+ xlab("Year") +
  ggtitle("Exponential Smoothing Sofware Developer III") +
  theme_minimal()



holt_Sof_Dev_III <-holt(holt_Sof_Dev_III ,h=7)
summary(holt_Sof_Dev_III)


round(accuracy(holt_Sof_Dev_III),2) %>% datatable(caption = "Sofware Developer III Errors")

holt_Sof_Dev_III$model$par %>%
  as.data.frame %>%
  datatable(caption = "Sofware Developer III Coefficients") %>%
  formatRound(c(1),digits = 7)



