"use strict"
define [
    'underscore'
    'backbone'
    'templates'
    'ventr',
    'utils/font'
], (_, Backbone, JST, ventr, fontUtils)->

    class WorldCloudView extends Backbone.View

        template: JST['app/scripts/templates/word.ejs']

        initialize: ->
            @listenTo @collection, 'reset', @render

        renderWord: (model)->
            data = model.toJSON()
            data.fontColor = fontUtils.calculateWordColor model
            data.fontSize = fontUtils.calculateWordSize model
            @template data

        render: ->
            @collection.forEach (model)=>
                @$el.append @renderWord(model)