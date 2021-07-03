library(tidyverse)




IT_Project_I <-df_final_matches %>%
  filter(Allwyn=="IT Project Manager I") %>%
  arrange(Year) %>%
  filter(Year=="2010")


ggplot(IT_Project_I%>%select(PRIM_STATE), aes(x=PRIM_STATE, color=PRIM_STATE)) +
  stat_count(geom="bar") +
  coord_flip()
  

St_Bar_Plot<-function(data) {
  
  
  Bar_plot <- ggplot(IT_Project_I%>%select(PRIM_STATE), aes(x=PRIM_STATE, color=PRIM_STATE)) +
    stat_count(geom="bar") +
    coord_flip()
  return(Bar_plot)
  
}

St_Bar_Plot(IT_Project_I)
