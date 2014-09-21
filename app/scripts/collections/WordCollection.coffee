define [
    'backbone',
    'models/WordModel'
], (Backbone, WordModel)->
    class WordCollection extends Backbone.Collection

        model: WordModel

        initialize: (options)->
            options = options or {}
            @wantsRandomSort = options.randomSort or no
            @popularity = { max: 0 }
            @listenTo @, 'reset change', @cachePopularity, @

            if @wantsRandomSort then @comparator = -> [-1,0,1][Math.floor(Math.random() * 3)]

        parse: (data)->
            data.topics

        cachePopularity: ->
            @popularity = {}
            mostPopular = @max (model)-> model.get('volume')
            @popularity.max = (mostPopular? and mostPopular.get('volume')) or 0