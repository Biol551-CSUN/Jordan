#02/10/2021
#Week 3 Lab 2
#Created by Shane E. Jordan

#load libraries
library(palmerpenguins)
library(tidyverse)
library(here)
library(beyonce)

#check out data
glimpse(penguins)

#make ggplot
ggplot(data=penguins,
       mapping = aes(x=bill_depth_mm,
                     y = bill_length_mm, group = species, 
                     color = species))+
  geom_point()+
  geom_smooth(method = "lm")+
      labs(x = "Bill depth (mm)",  
           y = "Bill length (mm)")+
    scale_color_viridis_d()+
    scale_x_continuous(limits=c(0,20))+
    scale_y_continuous(limits=c(0,50))
    
#ggplot with breaks
ggplot(data=penguins,
       mapping = aes(x=bill_depth_mm,
                     y = bill_length_mm, group = species, 
                     color = species))+
  geom_point()+
  geom_smooth(method = "lm")+
  labs(x = "Bill depth (mm)",  
       y = "Bill length (mm)")+
  scale_color_viridis_d()+
  scale_x_continuous(breaks = c(14, 17, 21),
  labels = c("low", "medium", "high"))

#add color manually
ggplot(data=penguins,
        mapping = aes(x=bill_depth_mm,
                       y = bill_length_mm, group = species, 
                       color = species))+
    geom_point()+
    geom_smooth(method = "lm")+
    labs(x = "Bill depth (mm)",  
         y = "Bill length (mm)")+  
    scale_color_manual(values = c("orange", "purple", "green"))

#coord flip/fix
ggplot(data=penguins,
       mapping = aes(x=bill_depth_mm,
                     y = bill_length_mm, group = species, 
                     color = species))+
  geom_point()+
  geom_smooth(method = "lm")+
  labs(x = "Bill depth (mm)",  
       y = "Bill length (mm)")+  
  coord_flip()+
  coord_fixed()

#transform
ggplot(diamonds, aes(carat, price)) +
  geom_point()

ggplot(diamonds, aes(carat, price)) +
  geom_point() +
  coord_trans(x = "log10", y = "log10")

#change coords
ggplot(data=penguins, 
       mapping = aes(x = bill_depth_mm,
                     y = bill_length_mm,
                     group = species,
                     color = species)) + 
  geom_point()+ 
  geom_smooth(method = "lm")+ 
  labs(x = "Bill depth (mm)", 
       y = "Bill length (mm)"
  ) +
  scale_color_manual(values = beyonce_palette(10)) +
  coord_polar("x") # make the plot polar

#themes
ggplot(data=penguins, 
       mapping = aes(x = bill_depth_mm,
                     y = bill_length_mm,
                     group = species,
                     color = species)) + 
  geom_point()+ 
  geom_smooth(method = "lm")+ 
  labs(x = "Bill depth (mm)", 
       y = "Bill length (mm)"
  ) +
  theme_bw()+
  theme(axis.title = element_text(size=15, color="black"),
  panel.background = element_rect(fill = "linen"))+
  ggsave(here("Week_3","Output","penguin.png"),
         width = 7, height = 5)

#save plot as object
plot1<-ggplot(data=penguins, 
              mapping = aes(x = bill_depth_mm,
                            y = bill_length_mm,
                            group = species,
                            color = species)) + 
  geom_point()+ 
  geom_smooth(method = "lm")+ 
  labs(x = "Bill depth (mm)", 
       y = "Bill length (mm)"
  ) +
  theme_bw()+
  theme(axis.title = element_text(size=15, color="black"),
        panel.background = element_rect(fill = "linen"))+
  ggsave(here("Week_3","Output","penguin.png"),
         width = 7, height = 5)
## geom_smooth() using formula 'y ~ x'
