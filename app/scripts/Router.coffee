'use strict'
define [
    'backbone'
    'ventr'
], (Backbone, ventr) ->
    # app router
    class Router extends Backbone.Router

        routes:
            # '' and 'home' both fire index
            '': 'index'
            # this prevents unwanted scrolling behavior when navigating to ''
            'home': 'index'
            ':topicUrlSegment': 'showTopicInfo'

        index: ->
            # delegate close topic info view
            ventr.trigger 'TopicInfoView:close'

        showTopicInfo: (topicUrlSegment)->
            # delegate showing of topic info to TopicInfoView instance
            ventr.trigger 'TopicInfoView:show', topicUrlSegment