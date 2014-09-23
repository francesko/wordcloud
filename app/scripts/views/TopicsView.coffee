'use strict'
define [
    'underscore'
    'backbone'
    'templates'
    'ventr',
    'utils/helpers'
], (_, Backbone, JST, ventr, helpers)->

    # view which displays a list of topics
    class TopicsView extends Backbone.View

        template: JST['app/scripts/templates/topic.ejs']

        events: ->
            'click .js-topic': 'showTopicInfo'

        initialize: ->
            # rerender when the collection content changes
            @listenTo @collection, 'reset change', @render

        renderTopic: (topic)->
            data = topic.toJSON()
            # set rendering attributes
            data.fontColor = helpers.calculateTopicColor topic
            data.fontSize = helpers.calculateTopicSize topic
            data.urlSegment = helpers.generateUrlSegment topic
            @template data

        render: ->
            @$el.empty()
            @collection.forEach (topic)=>
                @$el.append @renderTopic(topic)

        showTopicInfo: (e)->
            e.preventDefault()
            topicUrlSegment = $(e.currentTarget).data 'topic-urlsegment'
            # delegate showing of topic info to TopicInfoView instance
            ventr.trigger 'TopicInfoView:show', topicUrlSegment