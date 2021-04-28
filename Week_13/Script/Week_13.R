#week 13 Group Lab
#04/26/2021

#clear the environment
rm(list=ls())

library(here)
library(tidyverse)

#assign data location
TP1<-read_csv(here("Week_13", "Data", "TP1.csv"))
view(TP1)

#create path
TPpath<-here("Week_13", "Data")

#call files
files <- dir(path = TPpath,pattern = ".csv")
files

#allocate space for summary stats
TPdata<-data.frame(matrix(nrow = length(files), ncol = 5))

#add column names
colnames(TPdata)<-c("filename","mean_temp", "stdev_temp", "mean_light", "stdev_light")
TPdata

#test the first file
raw_data<-read.csv(paste0(TPpath,"/",files[1])) 
head(raw_data)

#calculate mean
mean_temp<-mean(raw_data$Temp.C, na.rm = TRUE)
mean_temp

#use for loop
for (i in 1:length(files)){ # loop over 1:3 the number of files 
  raw_data<-read_csv(paste0(TPpath,"/",files[i]))
  #glimpse(raw_data)
  TPdata$filename[i]<-files[i]
  TPdata$mean_temp[i]<-mean(raw_data$Temp.C, na.rm =TRUE)
  TPdata$mean_light[i]<-mean(raw_data$Intensity.lux, na.rm =TRUE)
  TPdata$stdev_temp[i]<-sd(raw_data$Temp.C, na.rm =TRUE)
  TPdata$stdev_light[i]<-sd(raw_data$Intensity.lux, na.rm =TRUE)
} 
TPdata

#use purr
files <- dir(path = TPpath,pattern = ".csv", full.names = TRUE)
#save the entire path name
files

data<-files %>%
  set_names()%>% # set's the id of each list to the file name
  map_df(read_csv,.id = "filename") %>% # map everything to a dataframe and put the id in a column called filename
  group_by(filename) %>%
  summarise(mean_temp = mean(Temp.C, na.rm = TRUE),
            mean_light = mean(Intensity.lux,na.rm = TRUE),
            sd_temp = sd(Temp.C, na.rm = TRUE),
            sd_light = sd(Intensity.lux,na.rm = TRUE))
data
