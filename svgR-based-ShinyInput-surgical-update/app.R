library(shiny)
source("ellipseCntrl.R")

ui <- fluidPage(
    titlePanel('Simple svgR-based radio controls with some update meager capabilities'),
    fluidRow(
        column(6, wellPanel(
            h2("First simple svgR-based control"),
            ellipseCntrl(inputId='ellipseCntrlId1', wh=c(300,100)), # This is the first custom control instance
            h5(textOutput('lastClicked1')),
            wellPanel( # below is for testing updating the first custom control
              h3("Update the First svgR-based Control") ,
                radioButtons( inputId='radioId1', label='Set the value inside the svgR control by setting the clicking on the radio buttons below', choices=c('left','right'), inline=T),
                fluidRow( h5(strong('Set stroke attributes of the ellipses inside the svgR control by setting the values in the select boxes below')),
                    column(3,selectInput('strokeColor1','Color', choices=c('black','gold','red','none'))),
                    column(3,selectInput('strokeWidth1','Width', choices=c(1,5,10,20)))
                )
            )
        )),
        column(6, wellPanel(
            h2("Second simple svgR-based control"),
            ellipseCntrl(inputId='ellipseCntrlId2', wh=c(300,100)), # This is the second custom control instance
            h5(textOutput('lastClicked2')),
            wellPanel( # below is for testing updating the second custom control
                h3("Update the Second  svgR-based Control") ,
                radioButtons( inputId='radioId2', label='Set the value inside the svgR control by setting the clicking on the radio buttons below', choices=c('left','right'), inline=T),
                fluidRow( h5(strong('Set stroke attributes of the ellipses inside the svgR control by setting the values in the select boxes below')),
                          column(3,selectInput('strokeColor2','Color', choices=c('black','gold','red','none'))),
                          column(3,selectInput('strokeWidth2','Width', choices=c(1,5,10,20)))
                )
            )
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
    
    # the remaining code below is just for testing updating the control
    
    # stroke width and stroke color
    observeEvent(c(input$strokeColor1, input$strokeWidth1),{
        updateEllipseCntrl(session=session, inputId="ellipseCntrlId1" ,stroke=input$strokeColor1, stroke.width=input$strokeWidth1)
    })
    observeEvent(c(input$strokeColor2, input$strokeWidth2),{
        updateEllipseCntrl(session=session, inputId="ellipseCntrlId2" ,stroke=input$strokeColor2, stroke.width=input$strokeWidth2)
    })
    # update the custom control value when radio button choice changes
    observeEvent(input$radioId1,{
        if(input$radioId1!=input$ellipseCntrlId1){
            updateEllipseCntrl(session=session, inputId="ellipseCntrlId1" , value=input$radioId1)
        }
    })
    observeEvent(input$radioId2,{
        if(input$radioId2!=input$ellipseCntrlId2){
            updateEllipseCntrl(session=session, inputId="ellipseCntrlId2" , value=input$radioId2)
        }
    })
    # update radio button choice when custom the control value changes
    observeEvent(input$ellipseCntrlId1,{
        if(input$radioId1!=input$ellipseCntrlId1){
            updateRadioButtons(session=session, inputId="radioId1" , selected=input$ellipseCntrlId1)
        }
    })
    observeEvent(input$ellipseCntrlId2,{
        if(input$radioId2!=input$ellipseCntrlId2){
            updateRadioButtons(session=session, inputId="radioId2" , selected=input$ellipseCntrlId2)
        }
    })
}
shinyApp(ui = ui, server = server)

