'use strict'
define [
    'backbone'
    'ventr'
], (Backbone, ventr) ->
    # app router
    class Router extends Backbone.Router

        routes:
            # no hash and 'home' both fire index
            '': 'index'
            # latter is used when closing the info view to prevent scrolling to top
            'home': 'index'
            ':topicUrlSegment': 'showTopicInfo'

        index: ->
            ventr.trigger 'TopicInfoView:close'

        showTopicInfo: (topicUrlSegment)->
            # delegate showing of topic info to TopicInfoView instance
            ventr.trigger 'TopicInfoView:show', topicUrlSegment