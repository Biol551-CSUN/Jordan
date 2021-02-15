#02/15/2021
#Week 4 Lab 1
#Created by Shane E. Jordan

#load libraries
library(palmerpenguins)
library(tidyverse)
library(here)

#glimpse
glimpse(penguins)

#filter
filter(.data = penguins, sex == "female")
filter(.data = penguins, year == "2008")
filter(.data = penguins, body_mass_g > 5000)
filter(.data = penguins, sex == "female", body_mass_g > 4000)
filter(.data = penguins, sex == "female" & body_mass_g > 4000) #same as above
filter(.data = penguins, year == "2008" | year == "2009")
filter(.data = penguins, island a! "Dream")
filter(.data = penguins, island == "Gentoo" & island == "Adelie") 

#mutate
data2 <- mutate(.data = penguins, body_mass_kg = body_mass_g/1000)
view(data2)

data3 <- mutate(.data = penguins, body_mass_kg = body_mass_g/1000, 
               bill_length_depth = bill_length_mm/bill_depth_mm)
view(data3)

data4 <- mutate(.data = penguins, after_2008 = ifelse(year>=2008, "After 2008", "Before 2008"))
view(data4)

data5 <- mutate(.data = penguins, flipper_length_mass = flipper_length_mm + body_mass_g)
view(data5)

data6 <- mutate(.data = penguins, cap_sex = ifelse(sex == "male", "Male", "Female"))
view(data6)