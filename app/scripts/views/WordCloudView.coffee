define [
    'underscore'
    'backbone'
    'templates'
    'ventr'
], (_, Backbone, JST, ventr)->
    wordTemplate = JST['app/scripts/templates/word.ejs']

    class WorldCloudView extends Backbone.View

        events:
            'click .js-word': 'showWordInfo'

        # six levels of popularity
        popularityRanges: [[100,50],[50,25],[25,12],[12,6],[6,3],[3,0]]

        initialize: ->
            @listenTo @collection, 'reset', @render

        renderWord: (model)->
            data = model.toJSON()
            data.fontColor = @calculateWordColor model
            data.fontSize = @calculateWordSize model
            @$el.append wordTemplate(data)

        render: ->
            @collection.forEach @renderWord, @
        
        showWordInfo: (e)->
            e.preventDefault()
            # TODO
            console.log $(e.currentTarget).data('id')

        calculateWordColor: (model)->
            fontColor = 'grey'
            sentimentScore = model.get('sentimentScore')
            
            if sentimentScore > 60
                fontColor = 'green'
            else if sentimentScore < 40
                fontColor = 'red'
            
            fontColor

        calculateWordSize: (model)->
            popularity = Math.floor (model.get('volume') / @collection.popularity.max) * 100
            
            fontSize = 6
            range = _.find @popularityRanges, (range, index)->
                if popularity <= range[0] and popularity >= range[1]
                    fontSize = index + 1
                    return yes

            fontSize