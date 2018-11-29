library(shiny)
source("ellipseCntrl.R")

ui <- fluidPage(
    titlePanel('Simple svgR-based radio controls with sans update capabilities'),
    fluidRow(
        column(6, wellPanel(
            h2("First simple svgR-based control"),
            ellipseCntrl(inputId='ellipseCntrlId1', wh=c(300,100)), # This is the first custom control instance
            h5(textOutput('lastClicked1'))#,
        )),
        column(6, wellPanel(
            h2("Second simple svgR-based control"),
            ellipseCntrl(inputId='ellipseCntrlId2', wh=c(300,100)), # This is the second custom control instance
            h5(textOutput('lastClicked2'))#,
        ))
    )
)
server <- function(input, output, session) {
    # returns  the current value of the control
    output$lastClicked1<- renderText({
        paste0("Current svgR Value1=", input$ellipseCntrlId1 )
    })
    output$lastClicked2<- renderText({
        paste0("Current svgR Value2=", input$ellipseCntrlId2 )
    })
}
shinyApp(ui = ui, server = server)

