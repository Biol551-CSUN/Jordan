#week 12 Group Lab
#04/21/2021

#clear the environment
rm(list=ls())

library(here)
library(tidyverse)
library(janitor)

intertidal_data<-read_csv(here("Week_12","Data","intertidaldata.csv"))
view(intertidal_data)

unique(intertidal_data$Quadrat) #look for any problems in the syntax
#we have "." and "1" that should not be there

#make a new data frame without these mistakes
clean_data <- intertidal_data %>%
  clean_names() %>%
  mutate(quadrat = str_replace_all(quadrat, pattern = "\\.", replacement = " ")) %>% #take out .'s
  mutate(quadrat = str_replace_all(quadrat, pattern = "[:digit:]|\\:", replacement = "")) %>% #take out digits
  mutate(quadrat = str_trim(quadrat, side = "right"))

view(clean_data)

level_order <- c("Low", "Mid", "High") #order the levels of our factor
clean_data %>%
  ggplot(aes(x = factor(quadrat, level = level_order), y = gooseneck_barnacles))+
  geom_col()+
  facet_wrap(~site)+
  xlab("Tidal Height")+
  ylab("Gooseneck Barnacles (n)")+
  theme_bw()+
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank())+
  ggsave(here("Week_12", "Output", "Barnacles_Plot.png"), width = 9, height = 9)
