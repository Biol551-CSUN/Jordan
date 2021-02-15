#02/03/2021
#Week 2 lab
#Created by Shane E. Jordan

#load in libraries
library(tidyverse)
library(here)

#read in data
weight<-read_csv(here("Week_2","Data","weightdata.csv")) #tidyverse code
weight<-read.csv("Week_2/Data/weightdata.csv") #base R code
view(weight)

#data analysis
head(weight)
tail(weight)