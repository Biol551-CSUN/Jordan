#02/24/2021
#Week 5 Group Lab 2

#Clear the environment
rm(list=ls())

#load libraries
library(tidyverse)
library(tidyr)
library(dplyr)
library(here)
library(lubridate)

#load data
condata<-read.csv("Week_5/Data/CondData.csv")
depthdata<-read.csv("Week_5/Data/DepthData.csv")

#first try
datetimes<-condata$date
datetimes<-ymd_hms(datetimes) #put in ymd_hms format
datetimes<-round_date(datetimes, "10 seconds") #round to 10 secs
df1 <- condata %>%
  mutate(DateTime = ymd_hms(datetimes)) 
head(df1)  
df2 <-depthdata %>%
  mutate(DateTime = ymd_hms(date))
head(df2)

df1 <-as.data.frame(df1) #make data frames
df2 <-as.data.frame(df2)
#join data frames
df3 <- inner_join(df1, df2) 
head(df3) #doesn't work right
df3 <- full_join(df1, df2) 
head(df3) #depthdata is missing

#let's try something different
condata$date <- ymd_hms(condata$date) %>%
  round_date(condata$date, "10 secs")
depthdata$date <- ymd_hms(depthdata$date) #gives error

#join data frames
joindata<-inner_join(condata, depthdata) #doesn't work!

#make averages
avgs1 <- df1 %>%
  summarise(meandate = mean(DateTime), meantemp = mean(TempInSitu),
            meansal = mean(SalinityInSitu_1pCal))
avgs1 <- as.data.frame(avgs1) #avg conddata

avgs2 <- df2 %>%
  summarise(meandate = mean(DateTime), meandepth = mean(Depth), 
                        meantemp = mean(AbsPressure))
avgs2 <- as.data.frame(avgs2) #avg depthdata

#make summary stats for ggplot
meandate1<- df1 %>%
  summarise(meandate = mean(DateTime))
meantemp1<- df1 %>%
  summarise(meantemp = mean(TempInSitu))
meansal<- df1 %>%
  summarise(meansal = mean(SalinityInSitu_1pCal))
meandate2<- df2 %>%
  summarise(meandate = mean(DateTime))
meantemp2<- df2 %>%
  summarise(meantemp = mean(AbsPressure))
meandepth<- df2 %>%
  summarise(meansal = mean(Depth))

#make ggplot of avgs
graphdata<-matrix(c(meandate1, meansal, meantemp1), nrow=1, ncol=3)
graphdata<-as.data.frame
datasets<-c("Mean Date", "Mean Salinity", "Mean Temperature")
variables<-c(meandate1, meansal, meantemp1)
ggplot(graphdata, aes(x = datasets, y = variables))+
  geom_col() #doesn't work 

#make better plot
#make barplots with variable by site and errorbars
model1<-lm(DateTime~TempInSitu*SalinityInSitu_1pCal, data = df1) #make linear model
library(emmeans)
graphdata<-as.data.frame(emmeans(model1, ~TempInSitu*SalinityInSitu_1pCal)) #make summary stats
graphdata #hmm something wrong here too
library(ggplot2)
ggplot(graphdata, aes(x = TempInSitu, y = emmean, fill=factor(SalinityInSitu_1pCal), group=factor(SalinityInSitu_1pCal))) +
  geom_col()+
  geom_errorbar(aes(ymax=upper.CL, ymin=lower.CL))
          
