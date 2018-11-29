library(svgR)

# --- begin  R-code for input control contruction for the server---

# constructs the svg object
ellipseCntrlSvg<-function(WH, ids=c('id1','id2'), relayClick="", textLeft='left',textRight='right'){
    # svgR setup
    rxy2<-rxy1<-cxy1<-.25*WH
    cxy2<-c(.75,.25)*WH
    # svgR construction
    svgR(wh=WH,
         g(
             ellipse(id=ids[1], cxy=cxy1, rxy=rxy1, fill='lightgreen', stroke='black', stroke.width=1,
                     set(attributeName='fill',to='pink', begin=paste0(ids[2],'.click')),
                     set(attributeName='fill',to='lightgreen', begin='click')
             ),
             text(textLeft, cxy=cxy1, stroke="black", fill='white', font.size=20),
             onClick=relayClick('left')
         ),
         g(
             ellipse(id=ids[2], cxy=cxy2, rxy=rxy2, fill='pink', stroke='black',stroke.width=1,
                     set(attributeName='fill',to='pink', begin=paste0(ids[1],'.click')),
                     set(attributeName='fill',to='lightgreen', begin='click')
             ),
             text(textRight, cxy=cxy2, stroke="black", fill='white', font.size=20),
             onClick=relayClick('right')
         )
    )
}

# prepares the svg for insertion into the controls tagList
newEllipseCntrl<-function(WH, ids, relayClick=""){
    svg<-ellipseCntrlSvg(WH, ids, relayClick)
    HTML(as.character(svg))
}

# constructor for the custom control
ellipseCntrl<-function(inputId, wh){
    ids<-paste0(inputId,c('id1','id2'))
    relayClick<-function(value=""){sprintf("ellipseCntrlBinding.setValue('#%s','%s')",inputId,value)}
    tagList(
        singleton(tags$head(tags$script(src = "ellipseCntrl.js"))),
        div( id=inputId, newEllipseCntrl(WH=wh,  ids=ids, relayClick=relayClick), class="ellipseCntrl" )        
    )
}

# --- ends R-code for input control contruction for the server---

