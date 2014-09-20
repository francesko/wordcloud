define [
    'backbone',
    'models/WordModel'
], (Backbone, WordModel)->
    class WordCollection extends Backbone.Collection

        model: WordModel

        initialize: ->
            @listenTo @, 'reset', @cachePopularity, @

        parse: (data)->
            data.topics

        cachePopularity: ->
            @popularity = {}

            mostPopular = @max (model)-> model.get('volume')
            leastPopular = @min (model)-> model.get('volume')

            @popularity.max = (mostPopular? and mostPopular.get('volume')) or 0
            @popularity.min = (leastPopular? and leastPopular.get('volume')) or 0

            total = @reduce (memo, model)->
                memo + model.get('volume')
            , 0

            @popularity.avg = total / @length

            console.log @popularity