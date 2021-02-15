#02/15/2021
#Week 4 Group Lab

#load libraries
library(palmerpenguins)
library(tidyverse)
library(here)

#Q1
penguins %>%
  drop_na(species, island, sex) %>%
  group_by(species, island, sex) %>%
  summarise(mean_body_mass = mean(body_mass_g, na.rm = TRUE), 
            var_body_mass=var(body_mass_g, na.rm = TRUE))

#Q2
penguins %>%
  drop_na(species, island, sex) %>%
  filter(sex == "female") %>%
  group_by(species, island, sex) %>%
  summarise(log_bodymass=log(body_mass_g)) %>%
  ggplot(aes(x = species, y = log_bodymass, color = species)) +
  geom_boxplot(show.legend = FALSE)+
  labs(x = "",  y = "Log (Body Mass)", color = "species")+
  scale_color_viridis_d()+
  theme_bw()+
  facet_wrap(~island)+
  theme(axis.title = element_text(size=12, color="black"))+
  ggsave(here("Week_4","Output","logbodymass.png"),
        width = 7, height = 5) #saves plot to output folder
  
  
   