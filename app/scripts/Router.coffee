define [
    'backbone'
    'ventr'
], (Backbone, ventr) ->

    class Router extends Backbone.Router

        routes:
            '': 'index'
            'home': 'index'
            ':topicUrlSegment': 'showTopicInfo'

        index: ->
            ventr.trigger 'TopicInfoView:close'

        showTopicInfo: (topicUrlSegment)->
            ventr.trigger 'TopicInfoView:show', topicUrlSegment