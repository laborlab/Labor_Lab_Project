source("C:/Users/willi/OneDrive/Desktop/Labor_Lab_Project/helpers/libraries.R")
#Sys.setenv('JAVA_HOME'="C:/Program Files/Java/jdk-11.0.1/") 

setwd("C:/Users/willi/OneDrive/Desktop/Labor_Lab_Project/data/Final")


#filenames<-list.files(pattern=".xlsx$")

filenames<-list.files(pattern=".csv$")
# create an empty list that will serve as a container to receive the incoming files

list_data<-list()

# create a loop to read in your data
for (i in 1:length(filenames))
{
  list_data[[i]]<-read.csv(filenames[i])
}

# add the names of your data to the list
names(list_data)<-filenames

df_MSA_2010<-list_data$MSA_M2010_dl_1.csv %>%
  mutate(Year="2010")

df_MSA_2011 <-list_data$MSA_M2011_dl_1_AK_IN.csv %>%
  mutate(Year="2011")

df_MSA_2012 <-list_data$MSA_M2012_dl_1_AK_IN.csv %>%
  mutate(Year="2012")

df_MSA_2013 <-list_data$MSA_M2013_dl_1_AK_IN.csv %>%
  mutate(Year="2013")


df_MSA_2014 <-list_data$MSA_M2014_dl.csv %>%
  mutate(Year="2014")

df_MSA_2015 <-list_data$aMSA_M2015_dl.csv %>%
  mutate(Year="2015")

df_MSA_2016 <-list_data$MSA_M2016_dl.csv %>%
  mutate(Year="2016")


df_MSA_2019 <-list_data$MSA_M2019_dl.csv %>%
  mutate(Year="2017")

df_Initial_list <- list_data$Initial_Input_Set.csv

rm(list_data)

###############################################
Jobs<- c("Information","Computer")


# #df_MSA_2015_clean <-clean_data(df_MSA_2015)
# 
# e<-quick_table(df_MSA_2015)
# 
# quick_table_salary(df_MSA_2015,"2015")
# 
# t<-map(df_MSA_2010,.f = clean_up)
# 
# t <-clean_up(df_MSA_2010)

Jobs<- c("Information","Computer","IT","Developer","Technology")
 
# df=df_MSA_2015%>%
#   filter(str_detect(OCC_TITLE, paste(Jobs, collapse = "|")))


#################################################

df_final <- df_MSA_2010 %>%
  bind_rows(df_MSA_2011,df_MSA_2012,df_MSA_2013,
            df_MSA_2014,df_MSA_2015, df_MSA_2016) %>%
  filter(!str_detect(OCC_TITLE,'All Occupations'))%>%
  filter(!str_detect(OCC_TITLE,'Management Occupations')) %>%
  filter(str_detect(OCC_TITLE, paste(Jobs, collapse = "|"))) %>%
   mutate(H_MEAN = replace(H_MEAN , H_MEAN=='*',"NA")) %>%
  mutate(A_MEAN = replace(A_MEAN , A_MEAN=='*',"NA")) %>%
  filter(H_MEAN!='NA' ) 
  
  #%>%
  #mutate(across(c(11,12)), is.numeric)

# df_final$H_MEAN<- as.numeric(df_final$H_MEAN)
# df_final$A_MEAN<- as.numeric(df_final$A_MEAN)
# 
# 
#  ggplot(df_final,aes(x=H_MEAN) )+ geom_histogram() +
#    facet_grid(rows="Year",cols=NULL)
#  
#  ggplot(df_final,aes(x=Year, y=H_MEAN))+ geom_line()
#  
#  ggplot(df_final,aes(x=Year, y=H_MEAN) )+ geom_line()
# 
#  
#  #ggplot(df_final,aes(x=A_MEAN),stat_bin(30))+ geom_histogram()

 
 
 #############

 
 
 
 df_missing <- df_MSA_2010 %>%
   bind_rows(df_MSA_2011,df_MSA_2012,df_MSA_2013,
             df_MSA_2014,df_MSA_2015, df_MSA_2016) %>%
   filter(!str_detect(OCC_TITLE,'All Occupations'))%>%
   filter(!str_detect(OCC_TITLE,'Management Occupations')) %>%
   filter(str_detect(OCC_TITLE, paste(Jobs, collapse = "|"))) %>%
   mutate(H_MEAN = replace(H_MEAN , H_MEAN=='*',"NA")) %>%
   mutate(A_MEAN = replace(A_MEAN , A_MEAN=='*',"NA")) %>%
   select(H_MEAN,A_MEAN)
 
 
 # df_missing$H_MEAN=="NA"
 
 n=nrow(df_missing)
 
 missing_values_table=sapply(df_missing, function(x) sum(x=="NA"))
 
 missing_values_table=sort(missing_values_table, decreasing= TRUE) 
 
 missing_values_table=as.data.frame(missing_values_table) %>%
   mutate(Total_Count=n,Percent_Missing_Values=missing_values_table/n)
 
 
 df_final_dc <- df_MSA_2010 %>%
   bind_rows(df_MSA_2011,df_MSA_2012,df_MSA_2013,
             df_MSA_2014,df_MSA_2015, df_MSA_2016) %>%
   filter(!str_detect(OCC_TITLE,'All Occupations'))%>%
   filter(!str_detect(OCC_TITLE,'Management Occupations')) %>%
   filter(str_detect(AREA_NAME,'Washington-Arlington')) %>%
   filter(str_detect(OCC_TITLE, paste(Jobs, collapse = "|"))) %>%
   mutate(H_MEAN = replace(H_MEAN , H_MEAN=='*',"NA")) %>%
   mutate(A_MEAN = replace(A_MEAN , A_MEAN=='*',"NA")) %>%
   filter(H_MEAN!='NA' ) %>%
   select(PRIM_STATE,OCC_TITLE,H_MEAN,A_MEAN)
 
 