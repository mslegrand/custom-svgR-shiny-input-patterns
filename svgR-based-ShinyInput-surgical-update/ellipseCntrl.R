library(svgR)

# --- begin  R-code for input control contruction for the server---

# constructs the svg object
ellipseCntrlSvg<-function(WH, relayClick="", textLeft='left',textRight='right'){
    # svgR setup
    rxy2<-rxy1<-cxy1<-.25*WH
    cxy2<-c(.75,.25)*WH
    # svgR construction
    svgR(wh=WH,
         g(
             ellipse('class'='right', cxy=cxy1, rxy=rxy1, fill='lightgreen', stroke='black', stroke.width=1),
             text(textLeft, cxy=cxy1, stroke="black", fill='white', font.size=20),
             onClick=relayClick('left')
         ),
         g(
             ellipse('class'='left', cxy=cxy2, rxy=rxy2, fill='pink', stroke='black',stroke.width=1),
             text(textRight, cxy=cxy2, stroke="black", fill='white', font.size=20),
             onClick=relayClick('right')
         )
    )
}

# prepares the svg for insertion into the controls tagList
newEllipseCntrl<-function(WH, relayClick=""){
    svg<-ellipseCntrlSvg(WH, relayClick)
    HTML(as.character(svg))
}

# constructor for the custom control
ellipseCntrl<-function(inputId, wh){
    relayClick<-function(value=""){sprintf("ellipseCntrlBinding.setValue('#%s','%s')",inputId,value)}
    tagList(
        singleton(tags$head(tags$script(src = "ellipseCntrl.js"))),
        div( id=inputId, newEllipseCntrl(WH=wh, relayClick ), class="ellipseCntrl" )        
    )
}

# --- ends R-code for input control contruction for the server---

# ---begins adding R-code for updating-------

updateEllipseCntrl <- function(session, inputId,  stroke=NULL, stroke.width=NULL, value=NULL) {
    dropNulls <- function(x) {x[!vapply(x, is.null, FUN.VALUE = logical(1))]}
    message <- dropNulls(list( strokeColor = stroke, strokeWidth=stroke.width, value=value))
    if(length(message)>0){
        session$sendInputMessage(inputId, message)
    }
}

# ---end adding R-code for updating-------
