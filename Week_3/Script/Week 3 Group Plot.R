#02/10/2021
#Group Plot

#load libraries
library(palmerpenguins)
library(tidyverse)
library(here)
library(ggplot2)
library(dplyr)

#check out data
glimpse(penguins)

#make ggplot
ggplot(data=penguins,
       mapping = aes(x = factor(island), #make island a factor
                     y = body_mass_g, color = island)) + #color code by island
          geom_violin(show.legend = FALSE)+ #make violin distributions
          facet_wrap(~species)+ #facet wrap by species
       labs(x = "",  
         y = "Body Mass (g)")+ #label axes, didn't want to label x 
       theme_bw()+ #set up background theme
        theme(axis.title = element_text(size=14, color="black"))+ #change text size
        guides(color = FALSE)+
        scale_color_viridis_d() #make friendly colors
        ggsave(here("Week_3","Output","penguin.png"),
         width = 7, height = 5) #saves plot to output folder
