library(shiny)
library(zcjs)

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("zcjs: demo"),

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
           zcjsOutput("zcjs")
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
}

# Run the application
shinyApp(ui = ui, server = server)
