library(shiny)
library(tigris)
library(shinydashboard)
library(shinyWidgets)
library(leaflet)
library(sf)
library(dplyr)
library(rvest)
library(janitor)
library(RColorBrewer)
library(readr)
library(stringr)

options(tigris_class = "sf")
options(tigris_use_cache = TRUE)

# Load U.S. state shapes
states_sf <- states()

# Calculate centroids for popup information
centroids_sf <- st_centroid(states_sf$geometry)

# Add centroids data to the sf object for easy access
states_sf$lon <- st_coordinates(centroids_sf)[, 1]
states_sf$lat <- st_coordinates(centroids_sf)[, 2]

states_sf <- states_sf %>% 
  mutate(state = tolower(NAME))

# Reading and preprocessing the COVID data
covid_final <- read_html("https://usafacts.org/visualizations/covid-vaccine-tracker-states/state/minnesota") %>%
  html_elements(css = "table") %>%
  html_table() %>%
  .[[1]] %>%
  janitor::clean_names() %>%
  mutate(across(c(2, 3, 4), parse_number)) %>%
  mutate(state = tolower(state))

diff <- c(setdiff(states_sf$state, covid_final$state), "alaska", "hawaii")
states_sf <- states_sf %>%
  filter(!state %in% diff)

# Merge COVID data with sf data
states_sf <- left_join(states_sf, covid_final, by = ("state" = "state"))
states_sf <- st_transform(states_sf, crs = 4326) 

# Define the UI
ui <- dashboardPage(
  dashboardHeader(title = "COVID-19 Vaccination Dashboard"),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Map", tabName = "map", icon = icon("globe")),
      menuItem("Data", tabName = "data", icon = icon("table")),
      menuItem("Histogram", tabName = "histogram", icon = icon("chart-bar")),
      menuItem("Description", tabName = "description", icon = icon("info-circle"))
    )
  ),
  dashboardBody(
    tabItems(
      # Map tab
      tabItem(tabName = "map",
              fluidRow(
                box(width = 12, leafletOutput("map")),
                pickerInput("variable", "Choose a variable:", choices = names(covid_final)[2:4],
                            options = list(`style` = "btn-info"), multiple = FALSE),
                pickerInput("colorScheme", "Choose Color Scheme:", choices = c("Spectral", "RdYlBu", "RdYlGn", "PiYG", "PRGn"),
                            options = list(`style` = "btn-success"), multiple = FALSE),
                actionButton("updateMap", "Update Map")
              )),
      # Data tab
      tabItem(tabName = "data",
              DT::dataTableOutput("dataTable")),
      # Histogram tab
      tabItem(tabName = "histogram",
              plotOutput("histPlot")),
      # Description tab
      tabItem(tabName = "description",
              h2("COVID-19 Vaccination Dashboard"),
              p("This dashboard visualizes the COVID-19 vaccination rates across the U.S. states."),
              p("Select different variables and color schemes to adjust the map visualization."),
              p("View detailed data and histograms of the selected variables."))
    )
  )
)

# Define the server logic
server <- function(input, output, session) {
  
 
  
  observe({
    # This will update the map when the updateMap button is clicked
    input$updateMap
    
    # Accessing reactive states_sf data
    data <- states_sf
    
    # Render Leaflet map
    output$map <- renderLeaflet({
      # Ensuring the input variables are ready
      if(is.null(data) || is.null(input$colorScheme) || is.null(input$variable)) {
        return(NULL)
      }
      
      # Generate the map
      leaflet(data) %>%
        addProviderTiles(providers$Stamen.TonerLite) %>%
        addPolygons(
          fillColor = ~colorNumeric(brewer.pal(8, input$colorScheme), data[[input$variable]])(data[[input$variable]]),
          color = "#000000", weight = 1, opacity = 1,
          fillOpacity = 0.7, smoothFactor = 0.5,
          highlightOptions = highlightOptions(weight = 3, color = "#666666", bringToFront = TRUE),
          popup = ~paste(str_to_title(NAME), ":", round(data[[input$variable]], 2), "%")
        ) %>%
        addCircleMarkers(
          lng = ~st_coordinates(st_centroid(geometry))[1],
          lat = ~st_coordinates(st_centroid(geometry))[2],
          weight = 1, radius = 5,
          color = "#FFFFFF", fillColor = "#FF0000", fillOpacity = 1,
          popup = ~paste(NAME, "Vaccination Rate:", round(data[[input$variable]], 2), "%")
        ) %>%
        addLegend(
          pal = colorNumeric(brewer.pal(8, input$colorScheme), range(data[[input$variable]], na.rm = TRUE)),
          values = ~data[[input$variable]], opacity = 1,
          title = input$variable, position = "bottomright"
        )
    })
  })
  
  # Render DataTable
  output$dataTable <- DT::renderDataTable({
    DT::datatable(data[c("NAME", input$variable)], options = list(pageLength = 10))
  })
  
  # Render Histogram
  output$histPlot <- renderPlot({
    hist(data[[input$variable]], breaks = 30, col = brewer.pal(8, input$colorScheme), border = "white",
         main = paste("Histogram of", input$variable), xlab = input$variable)
    abline(v = median(data[[input$variable]], na.rm = TRUE), col = "red", lwd = 2)
  })
  
}

# Run the application 
shinyApp(ui = ui, server = server)
