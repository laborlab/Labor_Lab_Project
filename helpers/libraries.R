library(tidyverse)
library(dplyr)
library(fuzzyjoin)
library(data.table)
library(readxl)
library(stringdist)
library(stringr)
#Sys.setenv('JAVA_HOME'="C:/Program Files/Java/jdk-11.0.1/") 
#library(RWeka)
library(tm)
library(DT)
library(janitor)
library(purrr)
library(data.table)


# df_loader<- function(df,x){
#   df <-list_data$x
#   return(df)
# }
# 
# 
# 
# clean_data <- function(data){
#   data %>%
#     filter(grepl('*', H_MEAN))
#   
# }


clean_data <- function(data){
  data <-df_MSA_2010 %>%
    filter(!str_detect(H_MEAN,'#')) 
  
}

clean_up <- function(data){
  
  e <-data %>%
    clean_names(case="all_caps")
 return(e)   
}


quick_table_salary <- function(data, year){
  
  d <-data %>%
    clean_names(case="all_caps") %>%
    filter(!str_detect(OCC_TITLE,'All Occupations'))%>%
    filter(!str_detect(OCC_TITLE,'Management Occupations')) %>%
    filter(str_detect(AREA_NAME,'Washington-Arlington')) %>%
    select(OCC_TITLE,H_MEAN,A_MEAN) %>%
    datatable(colnames = c('Title', 'Hourly Wage', 'Annual Wage'),caption = year)
  
  return(d)   
}


quick_table_salary_all <- function(data, year){
  
  f <- data %>%
    select(OCC_TITLE,H_MEAN,A_MEAN) %>%
    datatable(colnames = c('Title', 'Hourly Wage', 'Annual Wage'),caption = year)
  
  return(f)   
}






 