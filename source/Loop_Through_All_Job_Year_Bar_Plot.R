for (job in job_v) {
  
  for (val in year_v) {
    
    Cloud_engineer <-df_final_matches %>%
      filter(str_detect(Allwyn,job)) %>%
      arrange(Year) %>%
      filter(str_detect(Year,val))
    
    
    Plot_gg[[val]][[job]] <- ggplot(Cloud_engineer%>%select(PRIM_STATE), aes(x=PRIM_STATE, color=PRIM_STATE)) +
      stat_count(geom="bar") +
      coord_flip() +
      labs(title = glue('{job} {val}')) +
      ylab("Counts") +
      xlab("States")
    print( Plot_gg[[val]][[job]])
    
  }
  
}