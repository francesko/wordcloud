"use strict"
define [
    'backbone'
    'utils/helpers'
    'models/Topic'
], (Backbone, helpers, Topic)->
    class Topics extends Backbone.Collection

        model: Topic

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
            mostPopular = @max (topic)-> topic.get('volume')
            @popularity.max = (mostPopular? and mostPopular.get('volume')) or 0

        findByUrlSegment: (urlSegment)->
            @find (topic)-> helpers.generateUrlSegment(topic) is urlSegment
