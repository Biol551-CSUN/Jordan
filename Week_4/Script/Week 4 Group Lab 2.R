#02/17/2021
#Week 4 Group Lab 2

#load libraries
library(tidyverse)
library(here)

#load data
chemdata<-read.csv("Week_4/Data/chemicaldata_maunalua.csv")

#clean data
chemd<-chemdata %>%
  filter(complete.cases(.)) %>% #remove NA's
  separate(col = Tide_time,
           into = c("Tide", "Time"),
           sep = "_", #breaks col into two variables
           remove = FALSE) %>% #keeps original col's
  pivot_longer(cols = Salinity:Silicate, 
               names_to = "Variables", 
               values_to = "Values") %>% #make data long
  group_by(Variables, Site, Time, Tide) %>% #let's look a these 4 Categories
  summarise(mean_vals = mean(Values, na.rm = TRUE),
            var_vals = var(Values,na.rm = TRUE),
            sd_vals = sd(Values, na.rm = TRUE)) %>% 
  write_csv(here("Week_4","Output","chemd.csv"))

  #make ggplot
  #first let's separate variable by tide
  chemd %>%
  ggplot(aes(x = Tide, y = mean_vals)) +
    geom_col()+
    facet_wrap(~Variables, scales = 'free') #looks ok

  #make barplots with variable by site and errorbars
  model1<-lm(mean_vals~Variables*Site, data = chemd) #make linear model
  library(emmeans)
  graphdata<-as.data.frame(emmeans(model1, ~ Variables*Site)) #make summary stats
  graphdata
  library(ggplot2)
  ggplot(graphdata, aes(x = Site, y = emmean, fill=factor(Variables), group=factor(Variables))) +
    geom_col()+
    geom_errorbar(aes(ymax=upper.CL, ymin=lower.CL))+ #add upper and lower 95% confidence limits
    facet_wrap(~Variables, scales = 'free')
  
  #make barplots with variable by tide by site and errorbars
  model2<-lm(mean_vals~Variables*Tide*Site, data = chemd) 
  library(emmeans)
  graphdata<-as.data.frame(emmeans(model2, ~ Variables*Tide*Site)) #make into data frame
  graphdata #looks good
  library(ggplot2)
  ggplot(graphdata, aes(x = Tide, y = emmean, fill=factor(Variables), group=factor(Variables))) +
    theme(axis.title = element_text(size=12, color="black"), panel.grid.major = element_blank(), 
          panel.grid.minor = element_blank(),
          panel.background = element_blank(), axis.line = element_line(colour = "black"))+
    geom_col(show.legend = FALSE)+
    geom_errorbar(aes(ymax=upper.CL, ymin=lower.CL))+ #add error bars
    facet_wrap(~Site*Variables, scales = 'free')+ #separate variables by site
    labs(x="Tide", y="Concentration (umol/L)",
         caption = "Means +/- 95% Confidence Intervals of Variables During High and Low Tide at Two Sites in Mauna Lua, Source: Dr. Nyssa Silbiger")
  #ggsave
  ggsave(here("Week_4","Output","chems.png"),
         width = 7, height = 5) #saves plot to output folder
  
  #leftover code if we wanted to pivot with summary stats
  pivot_wider(names_from = Variables, # column with the names for the new columns
            values_from = c(mean_vals, var_vals, sd_vals))