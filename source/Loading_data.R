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

df_MSA_2010<-list_data$MSA_M2010_dl_1.csv

df_MSA_2011 <-list_data$MSA_M2011_dl_1_AK_IN.csv

df_MSA_2012 <-list_data$MSA_M2012_dl_1_AK_IN.csv

df_MSA_2013 <-list_data$MSA_M2013_dl_1_AK_IN.csv

df_MSA_2014 <-list_data$MSA_M2014_dl.csv

df_MSA_2015 <-list_data$aMSA_M2015_dl.csv

df_MSA_2016 <-list_data$MSA_M2016_dl.csv

df_MSA_2019 <-list_data$MSA_M2019_dl.csv

rm(list_data)

#df_MSA_2015_clean <-clean_data(df_MSA_2015)

#quick_table(df_MSA_2015)

quick_table_salary(df_MSA_2015,"2015")
