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
            # update the route when the modal is closed
            @$el.on 'hide.bs.modal', _.bind(@updateRoute, @)

        updateRoute: ->
            # change route back to 'home' when closing the info view
            Backbone.history.navigate '#/home'

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

        close: (e)->
            e.preventDefault() if e?
            # hide bootstrap modal
            @$el.modal 'hide'

        remove: ->
            # unbind events and remove the view
            @stopListening ventr
            @$el.removeData().unbind()
            Backbone.View::remove.call @
