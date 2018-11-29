library(svgR)

# --- begin  R-code for input control contruction for the server---

# constructs the svg object
ellipseCntrlSvg<-function(WH, inputId, relayClick="", stroke, stroke.width, choice, textLeft='left',textRight='right' ){
    # svgR setup
    rxy2<-rxy1<-cxy1<-.25*WH
    cxy2<-c(.75,.25)*WH
    ids<-paste0(inputId,c('id1','id2'))
    # svgR construction
    if(choice=='left'){
        fills<-c('lightgreen','pink')
    } else {
        fills<-c('pink','lightgreen')
    }
    svgR(wh=WH,
         g(
             ellipse(id=ids[1], cxy=cxy1, rxy=rxy1, fill=fills[1], stroke=stroke, stroke.width=stroke.width,
                     set(attributeName='fill',to='pink', begin=paste0(ids[2],'.click')),
                     set(attributeName='fill',to='lightgreen', begin='click')
             ),
             text(textLeft, cxy=cxy1, stroke="black", fill='white', font.size=20),
             onClick=relayClick('left')
         ),
         g(
             ellipse(id=ids[2], cxy=cxy2, rxy=rxy2, fill=fills[2], stroke=stroke, stroke.width=stroke.width,
                     set(attributeName='fill',to='pink', begin=paste0(ids[1],'.click')),
                     set(attributeName='fill',to='lightgreen', begin='click')
             ),
             text(textRight, cxy=cxy2, stroke="black", fill='white', font.size=20),
             onClick=relayClick('right')
         )
    )
}

# prepares the svg for insertion into the controls tagList
newEllipseCntrl<-function(WH, inputId, relayClick=""){
    svg<-ellipseCntrlSvg(WH,  inputId, relayClick, stroke='black', stroke.width=1, choice='left')
    HTML(as.character(svg))
}

# constructor for the custom control
ellipseCntrl<-function(inputId, wh){
    ids<-paste0(inputId,c('id1','id2'))
    relayClick<-function(value=""){sprintf("ellipseCntrlBinding.setValue('#%s','%s')",inputId,value)}
    tagList(
        singleton(tags$head(tags$script(src = "ellipseCntrl.js"))),
        div( id=inputId, newEllipseCntrl(WH=wh,  inputId, relayClick=relayClick), class="ellipseCntrl" )        
    )
} 

# --- ends R-code for input control contruction for the server---

# ---begins adding R-code for updating-------


updateEllipseCntrl <- function(session, inputId,  wh, stroke, stroke.width, choice) {
    relayClick<-function(value=""){sprintf("ellipseCntrlBinding.setValue('#%s','%s')",inputId,value)}
    svg<-ellipseCntrlSvg(WH=c(300,100), inputId, relayClick=relayClick, stroke=stroke, stroke.width=stroke.width, choice=choice )
    message=list(value=choice, svg=as.character(svg))
    if(length(message)>0){
        session$sendInputMessage(inputId, message)
    }
    
}

# ---end adding R-code for updating-------
