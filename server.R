#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(shinydashboard)
library(tidyverse)
mypath <- 'https://covidtracking.com/data/download/all-states-history.csv'
coviddata <- read_csv(mypath)

# Define server logic required to draw a histogram
shinyServer(function(input, output, session) {

    df <- reactiveFileReader(
        intervalMillis = 20000, 
        session = session,
        filePath = 'https://covidtracking.com/data/download/all-states-history.csv',
        readFunc = read_csv)
    
    observeEvent(input$state, {
        df <- df()
        mychoices = c(unique(df$state))
        updateSelectInput(session, "state", choices = mychoices, selected = "NY")
        updateDateInput(session, "date", min=min(df$date), max=max(df$date), value=max(df$date))
    },
    once = T)
    
    output$ncases <- renderInfoBox({
        df <- df()
        nc <- df %>% filter(date %in% input$date, state %in% input$state) %>% select(positive)
        infoBox(
            value = nc,
            title = "Positive Cases:",
            icon = icon('list')
        )
    })
    
    output$nhospitalized <- renderInfoBox({
        df <- df()
        nh <- df %>% filter(date %in% input$date, state %in% input$state) %>% select(hospitalized)
        infoBox(
            value = nh,
            title = "Hospitalizations:",
            icon = icon('hospital'),
            color = "purple",
            fill=TRUE)
    })

})
