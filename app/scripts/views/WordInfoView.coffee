define [
    'underscore'
    'backbone'
    'templates'
    'ventr'
    'utils/font'
    'bootstrap'
], (_, Backbone, JST, ventr, fontUtils)->

    class WordInfoView extends Backbone.View

        className: 'word-info modal fade'

        template: JST['app/scripts/templates/word-info.ejs']

        bgColors:
            positive: 'green'
            neutral: 'grey'
            negative: 'red'

        events:
            'click .js-wordinfo-close': 'close'

        initialize: ->
            @render()
            @listenTo ventr, 'WordInfoView:show', @show
            @listenTo ventr, 'WordInfoView:close', @close
            @$el.on 'click', _.bind(@close, @)

        show: (wordId)->
            word = @collection.get wordId

            if word?
                data = word.toJSON()
                data.fontColor = fontUtils.calculateWordColor word
                data.fontSize = fontUtils.calculateWordSize word
                data.bgColors = @bgColors
                data.sentiment =
                    positive: data.sentiment.positive or 0
                    neutral: data.sentiment.neutral or 0
                    negative: data.sentiment.negative or 0

                @$el.html @template(data)
                @$el.modal 'show'

        close: (e)->
            e.preventDefault() if e?
            @$el.modal 'hide'
            Backbone.history.navigate ''

        render: ->
            $('body').append @el
