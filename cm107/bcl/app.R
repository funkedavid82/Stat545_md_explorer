#install.packages("shiny")
library(shiny)

a <- 5
print(a^2)

bcl <- read.csv("bcl-data.csv", stringsAsFactors = FALSE)

# Define UI for application that draws a histogram
ui <- fluidPage(
  titlePanel("BC Liquor price app", 
             windowTitle = "BCL app"),
  sidebarLayout(
    sidebarPanel("This text is in the sidebar."),
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
   output$price_hist <- renderPlot(ggplot2::qplot(bcl$Price))
   output$bcl_data<- renderTable((bcl))
}

# Run the application 
shinyApp(ui = ui, server = server)

