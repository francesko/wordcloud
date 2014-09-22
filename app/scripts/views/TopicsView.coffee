"use strict"
define [
    'underscore'
    'backbone'
    'templates'
    'ventr',
    'utils/helpers'
], (_, Backbone, JST, ventr, helpers)->

    class TopicsView extends Backbone.View

        template: JST['app/scripts/templates/topic.ejs']

        initialize: ->
            @listenTo @collection, 'reset', @render

        renderTopic: (topic)->
            data = topic.toJSON()
            data.fontColor = helpers.calculateTopicColor topic
            data.fontSize = helpers.calculateTopicSize topic
            data.urlSegment = helpers.generateUrlSegment topic
            @template data

        render: ->
            @collection.forEach (topic)=>
                @$el.append @renderTopic(topic)