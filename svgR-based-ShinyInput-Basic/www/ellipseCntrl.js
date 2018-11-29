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
       $(el).data('choice',value);
       $(el).trigger("change");
    },
    subscribe: function(el, callback) {
        // notify server whever change 
        $(el).on("change.ellipseCntrlBinding", function(e) {
            callback();
        });
    },
    unsubscribe: function(el) {
        $(el).off(".ellipseCntrlBinding");
    }
});

// register input binding
Shiny.inputBindings.register(ellipseCntrlBinding);

