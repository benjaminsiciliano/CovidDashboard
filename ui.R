#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(shinydashboard)
library(tidyverse)

dashboardPage(
    dashboardHeader(title = "COVID Tracking Project"),
    dashboardSidebar(
        dateInput("date", "Select Date:"),
        selectInput("state", "Select State:", choices = NULL)
    ),
    dashboardBody(
        # Boxes need to be put in a row (or column)
        fluidRow(
            infoBoxOutput(width=5, "ncases"),
            infoBoxOutput(width=5, "nhospitalized")
        )
)
)
