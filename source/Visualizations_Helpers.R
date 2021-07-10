library(tidyverse)
library(glue)

year_v<-c("2010","2011","2012", "2013","2014","2015","2016")

Plot_gg<- list()
job_v <- c("Cloud Engineer","IT Project Manager I","IT Project Manager III",
           "Senior Computer Security Systems Specialist","Senior Security Analyst",
           "Senior Data Scientist","User Experience (UX) Developer","	Software Developer I","Software Developer II",
           "Test Automation Engineer")

# job_v <- c("User Experience (UX) Developer","	Software Developer I","Software Developer II",
#            "Test Automation Engineer")
# 
# job_v <- c("Cloud Engineer","IT Project Manager I","IT Project Manager III",
#            "Senior Computer Security Systems Specialist","Senior Security Analyst")


for (job in job_v) {
  
  for (val in year_v) {
    
    Cloud_engineer <-df_final_matches %>%
      filter(Allwyn==job) %>%
      arrange(Year) %>%
      filter(Year==val)
    
    
    Plot_gg[[val]][[job]] <- ggplot(Cloud_engineer%>%select(PRIM_STATE), aes(x=PRIM_STATE, color=PRIM_STATE)) +
      stat_count(geom="bar") +
      coord_flip() +
      labs(title = glue('{job} {val}')) +
      ylab("Counts") +
      xlab("States")
    print( Plot_gg[[val]][[job]])
    
  }
 
}

print(Plot_gg[["2010"]][["Test Automation Engineer"]])


St_Bar_Plot<-function(data,val) {
  
  IT_Project_I <-df_final_matches %>%
    filter(Allwyn=="Cloud Engineer") %>%
    arrange(Year) %>%
    filter(Year==val)
  
  Bar_plot <- ggplot(IT_Project_I%>%select(PRIM_STATE), aes(x=PRIM_STATE, color=PRIM_STATE)) +
    stat_count(geom="bar") +
    coord_flip()
  return(Bar_plot)
  
}



St_Bar_Plot(IT_Project_I,"2016")
#####################################
IT_Project_I <-df_final_matches %>%
  filter(str_detect(Allwyn,"Software Developer I")) %>%
  arrange(Year) %>%
  filter(Year=="2016")

 ggplot(IT_Project_I%>%select(PRIM_STATE), aes(x=PRIM_STATE, color=PRIM_STATE)) +
  stat_count(geom="bar") +
  coord_flip()

################################


####Testing###


# IT_Project_I <-df_final_matches %>%
#   filter(Allwyn=="Cloud Engineer") %>%
#   arrange(Year) %>%
#   filter(Year=="2016")
# 
# 
# ggplot(IT_Project_I%>%select(PRIM_STATE), aes(x=PRIM_STATE, color=PRIM_STATE)) +
#   stat_count(geom="bar") +
#   coord_flip() +
#   labs(title = "Cloud Engineer 2010") +
#   ylab("Counts") +
#   xlab("States")
# 
# 
# IT_Project_I <-df_final_matches %>%
#   filter(Allwyn=="Cloud Engineer") %>%
#   arrange(Year) %>%
#   filter(Year=="2011")
# 
# 
# ggplot(IT_Project_I%>%select(PRIM_STATE), aes(x=PRIM_STATE, color=PRIM_STATE)) +
#   stat_count(geom="bar") +
#   coord_flip() +
#   labs(title = "Cloud Engineer 2011") +
#   ylab("Counts") +
#   xlab("States")

#######Testing





year_v<-c("2010","2011","2012", "2013","2014","2015","2016")

Plot_gg<- list()

for (val in year_v) {
  
  IT_Project_Manager_I <-df_final_matches %>%
    filter(Allwyn=="IT Project Manager I") %>%
    arrange(Year) %>%
    filter(Year==val)
  
  
  Plot_gg[[val]] <- ggplot(Cloud_engineer%>%select(PRIM_STATE), aes(x=PRIM_STATE, color=PRIM_STATE)) +
    stat_count(geom="bar") +
    coord_flip() +
    labs(title = glue('IT Project Manager I {val}')) +
    ylab("Counts") +
    xlab("States")
  print( Plot_gg[[val]])
}
