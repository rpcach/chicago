#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(leaflet)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("City of Chicago, Affordable Rental Housing"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      conditionalPanel(condition="input.conditionalPanels==1",
                       selectInput(inputId = "propType",
                                   label = "Property Type:",
                                   choices = c("All","Senior","Multifamily","People with Disabilities","Supportive","Supportive/Veterans","Artist Live/Work Space","Artist Housing","ARO","Inter-generational"),
                                   selected = "All")),
      conditionalPanel(condition="input.conditionalPanels==2",
                       selectInput(inputId = "zipCode",
                                   label = "Zip Code:",
                                   choices = c("All",
                                               "60601","60605","60607","60608","60609","60610",
                                               "60612","60613","60614","60615","60616","60617",
                                               "60618","60619","60620","60621","60622","60623",
                                               "60624","60625","60626","60627","60628","60629",
                                               "60630","60631","60633","60634","60636","60637",
                                               "60638","60639","60640","60642","60643","60644",
                                               "60646","60647","60649","60651","60652","60653",
                                               "60657","60659","60660","60707"),
                                   selected="All")),
      conditionalPanel(condition="input.conditionalPanels==3",
                       selectInput(inputId = "CommType",
                                   label = "Community Area Name",
                                   choices = c("All",
                                               "Albany Park","Ashburn","Auburn Gresham","Austin",
                                               "Avalon Park","Belmont Cragin","Bridgeport","Chatham",
                                               "Chicago Lawn","Douglas","Dunning","East Garfield Park",
                                               "Edgewater","Englewood","Fuller Park","Gage Park",
                                               "Garfield Ridge","Grand Boulevard","Greater Grand Crossing",
                                               "Hegewisch","Humboldt Park","Hyde Park","Jefferson Park",
                                               "Kenwood","Lakeview","Logan Square","Loop","Lower West Side",
                                               "Montclare","Near North Side","Near South Side","Near West Side",
                                               "New City","North Center","North Lawndale","North Park",
                                               "Norwood Park","Oakland","Pullman","Riverdale","Rogers Park",
                                               "Roseland","South Chicago","South Lawndale","South Shore","Uptown",
                                               "Washington Heights","Washington Park","West Englewood",
                                               "West Garfield Park","West Lawn","West Pullman","West Ridge",
                                               "West Town","Woodlawn"),
                                   selected="All"))
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      tabsetPanel(type = "tabs", 
                  tabPanel("X,Y Scatter Plot", plotOutput("XY"), value = 1),
                  tabPanel("Property Types by Zip Code", plotOutput("Zip"), value = 2),
                  tabPanel("Long,Lat by Community Area", leafletOutput("LongLat"), value = 3),
                  id = "conditionalPanels"
      )
    )
  )
))
