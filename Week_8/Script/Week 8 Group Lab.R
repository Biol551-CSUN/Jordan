#03/24/2021
#Week 8 Group Lab

#libraries
library(tidyverse)
library(here)
library(ggplot2)
library(PNWColors)

#first make function to convert Celcius to Farenheit
C_F <- function(temp_C) {
  temp_F <- (temp_C*(9/5))+32
return(temp_F)
}

C_F(0)
C_F(32)
C_F(100)

#bring in data
chemdata<-read.csv("Week_8/Data/chemicaldata_maunalua.csv")

plotfx<-function(data = chemdata, x, y , ylim, Time="Day"){ 
  pal<-pnw_palette("Lake",3, type = "discrete")
if(Time == "Day"){
  data %>%
    filter(Time == "Day") %>%
    ggplot(aes(x = {{x}}, y = {{y}}, color = Site))+
    geom_point()+
    scale_color_manual("Site", values=pal)+
    theme_gray()
}
else{
  data %>%
    filter(Time == "Night") %>%
  ggplot(aes(x = {{x}}, y = {{y}}, color = Site))+
    geom_point()+
    scale_color_manual("Site", values=pal)+
    theme_gray() 
}
}

#test plot function
plotfx(x = Zone, y = pH)+
  labs(x = "", y = "pH")+
  scale_y_continuous(limits = c(7.5,9.0))+
  ggsave(here("Week_8","Output","ZonepH.png"),
         width = 7, height = 5)

plotfx(x = Tide_time, y = Temp_in)+
  labs(x = "Tide", y = "Temperature (C)")+
  ggsave(here("Week_8","Output","TideTemps.png"),
         width = 7, height = 5)

plotfx(x = Season, y = Salinity)+
  labs(x = "Season", y = "Salinity")+
  ggsave(here("Week_8","Output","SeasonSalinity.png"),
         width = 5, height = 5)
