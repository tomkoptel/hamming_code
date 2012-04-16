//= require ./libs/jquery.min.js
//= require ./libs/underscore.min.js
//= require ./libs/underscore.string.js
//= require ./libs/backbone.min.js
//= require ./libs/word_view.js
//= require ./libs/statistics.js
//= require ./libs/word_parser.js
//= require ./libs/hamming.js

//= require_tree ../templates/
//= require_tree ./app/views
//= require_tree ./app/routes

jQuery(function() {
    new MainRoutes();
    return Backbone.history.start({
        pushState: false,
        root: '/'
    });
});
