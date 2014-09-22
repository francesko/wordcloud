define [
    'backbone'
    'ventr'
], (Backbone, ventr) ->

    class Router extends Backbone.Router

        routes:
            '': 'index'
            'home': 'index'
            ':topicId': 'showTopicInfo'

        index: ->
            ventr.trigger 'TopicInfoView:close'

        showTopicInfo: (topicId)->
            ventr.trigger 'TopicInfoView:show', topicId