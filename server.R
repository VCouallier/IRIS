#package <- c("shiny","shinydashboard","ggplot2","dplyr","plyr","FactoMineR","GGally")
#new.packages <- package[!(package %in% installed.packages()[,"Package"])]
#if (length(new.packages)) install.packages(new.packages, repos='https://cloud.r-project.org')
#lapply(package, library, character.only=T)
#rm(list = c("package","new.packages"))

#library(shiny)
#require(shinydashboard)
library(ggplot2)
#library(dplyr)
#library(plyr)
#library(FactoMineR)
#library(GGally)

function(input, output, session) {

  # Combine the selected variables into a new data frame
  selectedData <- reactive({
    iris[, c(input$xcol, input$ycol)]
  })

  clusters <- reactive({
    kmeans(selectedData(), input$clusters)
  })

  output$plot1 <- renderPlot({
    palette(c("#E41A1C", "#377EB8", "#4DAF4A", "#984EA3",
      "#FF7F00", "#FFFF33", "#A65628", "#F781BF", "#999999"))

    par(mar = c(5.1, 4.1, 0, 1))
    plot(selectedData(),
         col = clusters()$cluster,
         pch = 20, cex = 3)
    points(clusters()$centers, pch = 4, cex = 4, lwd = 4)
  })

}

