#02/08/2021
#Week 3 Lab 1
#Created by Shane E. Jordan

#load libraries
library(palmerpenguins)
library(tidyverse)

#check out data
glimpse(penguins)

#make ggplot
ggplot(data=penguins,
       mapping = aes(x=bill_depth_mm,
                     y = bill_length_mm,
                     color = species, shape = island, size = body_mass_g)) +
  geom_point(size = 2)+
labs(title = "Bill depth and length",
     subtitle = "Dimensions for Adelie, Chinstrap, and Gentoo Penguins",
     x = "Bill depth (mm)",  y = "Bill length (mm)",
     color = "Species", shape = "Island", size = "Body Mass (g)",
     caption = "Source: Palmer Station LTER / palmerpenguins package")+
  scale_color_viridis_d()

#make ggplot faceted
ggplot(data=penguins,
  mapping = aes(x=bill_depth_mm,
                y = bill_length_mm,
                color = species, shape = island, size = body_mass_g)) +
  geom_point(size = 2)+
  facet_wrap(~species, ncol=2)
    labs(title = "Bill depth and length",
     subtitle = "Dimensions for Adelie, Chinstrap, and Gentoo Penguins",
      x = "Bill depth (mm)",  y = "Bill length (mm)",
      color = "Species", shape = "Island", size = "Body Mass (g)",
      caption = "Source: Palmer Station LTER / palmerpenguins package")+
      scale_color_viridis_d() 