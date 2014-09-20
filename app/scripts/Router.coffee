define [
    'backbone'
    'ventr'
], (Backbone, ventr, topics) ->

    class Router extends Backbone.Router

        routes:
            ':word': 'showWordInfo'

        showWordInfo: (word)->
            ventr.trigger 'word:showInfo'