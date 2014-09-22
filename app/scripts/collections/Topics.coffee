'use strict'
define [
    'backbone'
    'utils/helpers'
    'models/Topic'
], (Backbone, helpers, Topic)->
    # represents a list of Topics
    class Topics extends Backbone.Collection

        model: Topic

        initialize: (options)->
            options = options or {}
            # check if random sort is desired
            @wantsRandomSort = options.randomSort or no
            @popularity = { max: 0 }
            # listen to changes to recalculate max popularity
            @listenTo @, 'reset change', @cachePopularity, @
            # set random sort comparator if setting is on
            if @wantsRandomSort then @comparator = -> [-1,0,1][Math.floor(Math.random() * 3)]

        parse: (data)->
            data.topics

        cachePopularity: ->
            @popularity = {}
            mostPopular = @max (topic)-> topic.get('volume')
            # popularity.max stores the maximum popularity value used to compute topic importance
            @popularity.max = (mostPopular? and mostPopular.get('volume')) or 0

        findByUrlSegment: (urlSegment)->
            # look up a topic by urlSegment (id where spaces are replaced with dashes)
            @find (topic)-> helpers.generateUrlSegment(topic) is urlSegment
