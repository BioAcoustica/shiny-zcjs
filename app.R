library(shiny)
library(zcjs)
library(schite)

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("Demonstration of zcjs in Shiny"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
          checkboxInput("x_compress",
                        "x-compress",
                        value = FALSE,
                        width = NULL)
        ),

        # Show a plot of the generated distribution
        mainPanel(
           zcjsOutput("zcjs"),
           tabsetPanel(type = "tabs",
                       tabPanel("How to cite", htmlOutput("citation")),
                       tabPanel("Data Visualisation", htmlOutput("citevis")),
                       tabPanel("Misc", htmlOutput("citmisc"))
           )
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
    addResourcePath("demo", system.file('extdata', package = 'zcjs'))
    f <- "demo/demo.zc"
    output$zcjs <- renderZcjs({
        zcjs(f, x_compress=input$x_compress)
    })
    
    citation <- list(
      cite_bibentry(
        bibentry(
          bibtype="Misc",
          title="Demonstration of zcjs in Shiny",
          author="Ed Baker",
          url="http://shiny.ebaker.me.uk/shiny-zcjs/",
          year=2022
        )
      )
    )
    output$citation <- citationTabUI(citation)
    
    citvis <- list(
      cite_r_package("zcjs")
    )
    output$citevis <- citationTabUI(citvis)
    
    citmisc <- list(
      cite_r_package("schite"),
      cite_r_package("shiny")
    )
    output$citmisc <- citationTabUI(citmisc)
}

# Run the application
shinyApp(ui = ui, server = server)
