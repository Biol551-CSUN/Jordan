#Group Lab week 10
#making a shiny app

#clear the environment
rm(list=ls())

# Load libraries
library(tidyverse)
library(dplyr)
library(lubridate)
library(here)
library(janitor)

#load data
babies<-read.csv('Week_10/Data/HatchBabyExport.csv')
view(babies)

#clean up data
babiesclean<-babies %>%
  filter(Activity == c("Weight", "Feeding")) %>%
  separate(col = Start.Time, 
           into = c("Date", "Time"), sep = " ") %>%
  select(-Time, -End.Time, -Percentile, -Duration, -Notes, -Info, -X)
view(babiesclean)

#or make two separate data frames:

#weight
babiesweight<-babies %>%
  filter(Activity == "Weight") %>%
  separate(col = Start.Time, 
           into = c("Date", "Time"), sep = " ") %>%
  separate(col = Date, 
           into = c("Month", "Day", "Year"), sep = "/") %>%
  select(-Time, -End.Time, -Percentile, -Duration, -Notes, -Info, -X) 

babiesweight2 <- mutate(babiesweight, Date = paste(Day, Month, Year, sep ="-"))

view(babiesweight2)

#feeding
babiesfeed<-babies %>%
  filter(Activity == "Feeding") %>%
  separate(col = Start.Time, 
           into = c("Date", "Time"), sep = " ") %>%
  separate(col = Date, 
           into = c("Month", "Day", "Year"), sep = "/") %>%
  select(-Time, -End.Time, -Percentile, -Duration, -Notes, -X)

babiesfeed2 <- mutate(babiesweight, Date = paste(Day, Month, Year, sep ="-"))

view(babiesfeed2)

#make ggplot
babiesweight2 %>%
  ggplot(aes(x=Date, y=Amount))+
  geom_point()

babiesfeed2 %>%
  ggplot(aes(x=Date, y=Amount))+
  geom_point(breaks)
