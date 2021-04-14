library(tidyverse)
library(kableExtra)
library(shiny)
library(here)
library(lubridate)

#load data 
babies<-read_csv(here("Week_10","Data","HatchBabyExport.csv"))

#first analyze by weight
babiesweight<-babies %>%
    filter(Activity == "Weight") %>%
    separate(col = 'Start Time', 
             into = c("Date", "Time"), sep = " ") %>%
    separate(col = Date, 
             into = c("Day", "Month", "Year"), sep = "/") %>%
    mutate(babiesweight, Date = paste(Year, Month, Day, sep ="-"))%>%
    select(-Time, -'End Time', -Percentile, -Duration, -Info, -Notes, -X10, -Day, -Month, -Year) 

# Define UI
ui <- fluidPage(
    
    # Application title
    titlePanel("Baby Weight"),
    
    # Sidebar with a dropdown menu for baby name
    sidebarLayout(
        sidebarPanel(
            selectInput(
                inputId = "Baby Name",
                label = "Baby Name:",
                choices = unique(babiesweight$`Baby Name`),
                selected = "Blakely" # default selection
            ), 
        ),
        
        # Show a plot of the city-wide distribution
        mainPanel(column(6, # column() modifies the layout (# is the column width)
                         h4(""),
                         plotOutput("distPlot")),
                  p(), # a line break
                  p(),
        )
    ) # /mainPanel
) # /fluidPage

view(babiesweight)

# Server logic
server <- function(input, output) {
    output$distPlot <- renderPlot({
        # count of chosen breed x by district
        babiesweight %>%
            filter(`Baby Name`== input$`Amount`) %>%
            ggplot(aes(x = Date)) +
            xlab("Date") +
            ylab("Weight of Baby") +
            ggtitle(paste("Weight (pounds)", input$BabyName, "\n of each baby", sep = " ")) +
            geom_bar(fill = "#74CEB7") +
            theme_classic(base_size = 16)
    })
    
}

# Run the application
shinyApp(ui = ui, server = server)
