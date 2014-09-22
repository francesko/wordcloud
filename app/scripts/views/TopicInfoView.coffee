"use strict"
define [
    'underscore'
    'backbone'
    'templates'
    'ventr'
    'utils/helpers'
    'bootstrap'
], (_, Backbone, JST, ventr, helpers)->

    class TopicInfoView extends Backbone.View

        className: 'topic-info modal fade'

        template: JST['app/scripts/templates/topic-info.ejs']

        bgColors:
            positive: 'green'
            neutral: 'grey'
            negative: 'red'

        events:
            'click .js-topic-info-close': 'close'

        initialize: ->
            @$el.detach().modal()
            @listenTo ventr, 'TopicInfoView:show', @show
            @listenTo ventr, 'TopicInfoView:close', @close
            @$el.on 'hide.bs.modal', _.bind(@updateRoute, @)

        updateRoute: ->
            Backbone.history.navigate '#/home'

        show: (topicUrlSegment)->
            topic = @collection.findByUrlSegment topicUrlSegment

            if topic?
                data = topic.toJSON()
                data.fontColor = helpers.calculateTopicColor topic
                data.fontSize = helpers.calculateTopicSize topic
                data.bgColors = @bgColors
                data.sentiment =
                    positive: data.sentiment.positive or 0
                    neutral: data.sentiment.neutral or 0
                    negative: data.sentiment.negative or 0

                @$el.html @template(data)
                @$el.modal 'show'

        close: (e)->
            e.preventDefault() if e?
            @$el.modal 'hide'

        remove: ->
            @stopListening ventr
            @$el.removeData().unbind()
            Backbone.View::remove.call @
