'use strict'
define [
    'backbone'
    'ventr'
], (Backbone, ventr) ->
    # app router
    class Router extends Backbone.Router

        routes:
            '': 'index'
            ':topicUrlSegment': 'showTopicInfo'

        index: ->
            # close topic info view when going back to no route
            ventr.trigger 'TopicInfoView:close'

        showTopicInfo: (topicUrlSegment)->
            # delegate showing of topic info to TopicInfoView instance
            ventr.trigger 'TopicInfoView:show', topicUrlSegment