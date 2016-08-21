#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(leaflet)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  finaldata <- "https://data.cityofchicago.org/api/views/s6ha-ppgi/rows.csv?accessType=DOWNLOAD&bom=true"
  fd <- read.csv(finaldata, stringsAsFactors = FALSE)
  
  for(i in 1:nrow(fd)) {
    fd[i,"Community.Area.Name"] <- sub("\\s+$", "", fd[i,"Community.Area.Name"])
  }
   
  output$XY <- renderPlot({
    
    if(input$propType != "All") {
      plot(fd[which(fd$Property.Type == input$propType),"X.Coordinate"], fd[which(fd$Property.Type == input$propType),"Y.Coordinate"],
           xlim=c(1125000,1225000),ylim=c(1810000,1950000),
           xlab = "X-Coordinate", ylab = "Y-Coordinate")
    }  
    else {
      plot(fd[,"X.Coordinate"],fd[,"Y.Coordinate"],xlim=c(1125000,1225000),ylim=c(1810000,1950000),
           xlab = "X-Coordinate", ylab = "Y-Coordinate")
    }
    
  })
  
  output$Zip <- renderPlot({
    
    if(input$zipCode != "All") {
      fd2 <- fd[which(fd$Zip.Code == input$zipCode),]
      counts <- table(fd2$Property.Type)
      barplot(counts, xlab = "Property Type", ylab = "Units Available")
    }
    else {
      counts <- table(fd$Property.Type)
      barplot(counts, xlab = "Property Type", ylab = "Units Available")
    }
    
  })
  
  output$LongLat <- renderLeaflet({
    
    if(input$CommType != "All") {
      fd2 <- fd[which(fd$Community.Area.Name == input$CommType),]
      
      points <- eventReactive(input$recalc, {
        cbind(fd2[,"Longitude"],fd2[,"Latitude"])
      }, ignoreNULL = FALSE)
      
      leaflet() %>%
        addProviderTiles("Stamen.TonerLite",
                         options = providerTileOptions(noWrap = TRUE)
        ) %>%
        addMarkers(data = points())
    }
    else {
      points <- eventReactive(input$recalc, {
        cbind(fd[,"Longitude"],fd[,"Latitude"])
      }, ignoreNULL = FALSE)
      
      leaflet() %>%
        addProviderTiles("Stamen.TonerLite",
                         options = providerTileOptions(noWrap = TRUE)
        ) %>%
        addMarkers(data = points())
      
    }
    
  })
  
})
