#install.packages("shiny")
library(shiny)
library(tidyverse)


a <- 5
print(a^2)

bcl <- read.csv("bcl-data.csv", stringsAsFactors = FALSE)

# Define UI (user interface) for application that draws a histogram
ui <- fluidPage(
  titlePanel("BC Liquor price app", 
             windowTitle = "BCL app"),
  sidebarLayout(
    sidebarPanel(
      sliderInput("priceInput", "Select your desired price range.",
                  min = 0, max = 100, value = c(15, 30), pre="$"),
      radioButtons("typeInput", "Select your alcoholic beverage type.",
                   choices = c("BEER", "REFRESHMENT", "SPIRITS", "WINE"),
                   selected = "WINE")
    ),
    mainPanel(
      plotOutput("price_hist"), #identifying the type of plot.
      tableOutput("bcl_data") #stating a second output as a table.
      )
  )
  
  
  # "This is some text",
  # "This is more text.", #the two sentences will be on the same line if br() is not used
  # br(), #a break to go to the next line
  # "This is even more text.",
  # br(),
  # "More text",
  # tags$h1("Level 1 header"),
  # h1("Level 1 header, part 2"),
  # h1(em("Level 1 header, part 3")),
  # HTML("<h1>Level 1 header, part 4</h1>"),
  # a(href="https://google.ca", "Link to google!"),
  # (a)
   
)

# Define server logic required to draw a histogram
server <- function(input, output) {
   observe(print(input$priceInput)) #you only want to see the specified price range
   bcl_filtered <- reactive({ #filtering down to the price range specified
     bcl %>%
     filter(Price < input$priceInput[2],
            Price > input$priceInput[1],
            Type == input$typeInput)
    })
     output$price_hist <- renderPlot({
     bcl_filtered() %>%
       ggplot(aes(Price)) +
       geom_histogram()
   })
   output$bcl_data<- renderTable({
     bcl_filtered()
     })
}

# Run the application 
shinyApp(ui = ui, server = server)

