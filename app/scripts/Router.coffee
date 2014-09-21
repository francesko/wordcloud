define [
    'backbone'
    'ventr'
], (Backbone, ventr, topics) ->

    class Router extends Backbone.Router

        routes:
            '': 'index'
            ':wordId': 'showWordInfo'

        index: ->
            ventr.trigger 'WordInfoView:close'

        showWordInfo: (wordId)->
            ventr.trigger 'WordInfoView:show', wordId