







ggplot(ToothGrowth, aes(x=dose, y=len)) + 
  geom_boxplot(outlier.colour="red", outlier.shape=8,
               outlier.size=4)



for (job in job_v) {
  
  for (val in year_v) {
    
    Cloud_engineer <-df_final_matches %>%
      filter(str_detect(Allwyn,job)) %>%
      arrange(Year) %>%
      filter(str_detect(Year,val))
    
    
    Plot_gg[[val]][[job]] <- ggplot(Cloud_engineer%>%select(H_MEAN,Allwyn), aes(x=Allwyn,y=H_MEAN)) +
      geom_boxplot(outlier.colour="red", outlier.shape=8,
                   outlier.size=4) +
      labs(title = glue('{job} {val}')) +
      ylab("Counts") +
      xlab("States")
    print( Plot_gg[[val]][[job]])
    
  }
  
}