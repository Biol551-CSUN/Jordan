#Chaparral map

#clear the environment
rm(list=ls())

# Load libraries
library(tidyverse)
library(dplyr)
library(here)
library(maps)
library(mapdata)
library(mapproj)

#disjunct chaparral density
df<-read.csv('Final_Project/Data/ChaparralDensity.csv')
density<-df %>%
  rename(lat = ï..lat)
view(density)

# get data for counties
counties<-map_data("county")
counties<-as.data.frame(counties)
LASB<-counties %>%
  filter(subregion == c("los angeles", "san bernardino"))
view(LASB)

#make CA map with chaparral density embedded in
ggplot()+
  geom_polygon(data = LASB, 
               aes(x = long, 
                   y = lat,
                   group = group,
                   fill = subregion))+
  geom_point(data = density, 
             aes(x = long, 
                 y = lat,
                 size = density))+ 
  theme(panel.background = element_rect(fill = "white"))+
  coord_map(projection = "sinusoidal")

ggsave(here("Week_7","output","CApop.pdf"))
