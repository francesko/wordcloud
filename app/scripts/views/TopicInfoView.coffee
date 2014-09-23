'use strict'
define [
    'underscore'
    'backbone'
    'templates'
    'ventr'
    'utils/helpers'
    'bootstrap'
], (_, Backbone, JST, ventr, helpers)->
    # view which displays information about a Topic
    class TopicInfoView extends Backbone.View

        className: 'topic-info modal fade'

        template: JST['app/scripts/templates/topic-info.ejs']

        # used to color the badge showing mentions amount
        bgColors:
            positive: 'green'
            neutral: 'grey'
            negative: 'red'

        events:
            'click .js-topic-info-close': 'close'

        initialize: ->
            # listen to events coming from event publisher
            @listenTo ventr, 'TopicInfoView:show', @show
            @listenTo ventr, 'TopicInfoView:close', @close

        # find a topic by urlSegment and displays its info
        show: (topicUrlSegment)->
            topic = @collection.findByUrlSegment topicUrlSegment

            if topic?
                data = topic.toJSON()
                # set rendering attributes
                data.fontColor = helpers.calculateTopicColor topic
                data.fontSize = helpers.calculateTopicSize topic
                data.bgColors = @bgColors
                data.sentiment =
                    positive: data.sentiment.positive or 0
                    neutral: data.sentiment.neutral or 0
                    negative: data.sentiment.negative or 0

                @$el.html @template(data)
                # show bootstrap modal
                @$el.modal 'show'
                # push topic route to browser history
                Backbone.history.navigate topicUrlSegment

        close: (e)->
            e.preventDefault() if e?
            # hide bootstrap modal
            @$el.modal 'hide'

        remove: ->
            # unbind events and remove the view
            @$el.removeData().unbind()
            Backbone.View::remove.call @
