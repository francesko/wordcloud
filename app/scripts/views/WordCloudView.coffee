define [
    'underscore'
    'backbone'
    'ventr'
    'text!templates/word.jst'
], (_, Backbone, ventr, wordTemplate)->
    wordTemplate = _.template wordTemplate

    class WorldCloudView extends Backbone.View

        events:
            'click .js-word': 'showWordInfo'

        initialize: ->
            @listenTo @collection, 'reset', @render

        calculateWordColor: (model)->
            fontColor = 'grey'
            sentimentScore = model.get('sentimentScore')
            
            if sentimentScore > 60
                fontColor = 'green'
            else if sentimentScore < 40
                fontColor = 'red'
            
            fontColor

        renderWord: (model)->
            data = model.toJSON()
            data.fontColor = @calculateWordColor model
            @$el.append wordTemplate(data)

        render: ->
            @collection.forEach @renderWord, @
        
        showWordInfo: (e)->
            e.preventDefault()
            # TODO
            console.log $(e.currentTarget).data('id')