//CUSTOM EVENT HANDLER: SET VALUE(S) AND RELAY CHANGE

/*
$(document).on("newChoice", ".ellipseCntrl", function(evt, arg1) { //arg1 is the data value
    var el = $(evt.target); // evt.target is the button that was clicked
    el.data("choice",arg1); // 'choice' is custon event for this control
    el.trigger("change"); // triggers change event to signal to wake up shiny
    
});
*/


//https://www.r-bloggers.com/paging-widget-for-shiny-apps/


//BEGIN: INPUT BINDING
var ellipseCntrlBinding = new Shiny.InputBinding();
$.extend(ellipseCntrlBinding, {
    find: function(scope) {
        console.log('find');
        return $(scope).find(".ellipseCntrl");
    },
    // return the ID of the DOM element
    
    initialize: function(el){
        // should we initialize value here?
        $(el).data("choice", 'left'); //sets the initial value
        console.log('initialize');
    },
    getValue: function(el) {// used to return the value of the input control
        return $(el).data('choice');
    },
    setValue: function(el, value) { // used for updating input control
        console.log('entering setValue');
        console.log('el='+JSON.stringify(el));
        console.log('value='+JSON.stringify(value));
        $(el).data('choice',value);
        if(value=='left'){
            $(el).find('ellipse').filter('.right').attr('fill','lightgreen');
            $(el).find('ellipse').filter('.left').attr('fill','pink');
        } else {
           $(el).find('ellipse').filter('.left').attr('fill','lightgreen');
           $(el).find('ellipse').filter('.right').attr('fill','pink');
        }
        $(el).trigger("change");
        console.log('setValue');
    },
    subscribe: function(el, callback) {
        $(el).on("change.ellipseCntrlBinding", function(e) {
            callback();
        });
    },
    unsubscribe: function(el) {
        $(el).off(".ellipseCntrlBinding");
    },
    receiveMessage: function(el, data) { // used for updating input control
        console.log("entering receiveMessage");
        console.log('el='+JSON.stringify(el));
        
        if(!!data.strokeColor){
            $(el).find('ellipse').attr('stroke', data.strokeColor);
        }
        if(!!data.strokeWidth){
            $(el).find('ellipse').attr('stroke-width', data.strokeWidth);
        }
        if(!!data.value){
            this.setValue($(el), data.value);
        }
    }
});

Shiny.inputBindings.register(ellipseCntrlBinding);

