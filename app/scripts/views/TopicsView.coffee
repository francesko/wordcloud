'use strict'
define [
    'underscore'
    'backbone'
    'd3'
    'd3cloud'
    'templates'
    'ventr',
    'utils/helpers'
], (_, Backbone, d3, d3cloud, JST, ventr, helpers)->

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
            if not Modernizr.svg
                # no svg fallback
                @collection.forEach (topic)=>
                    @$el.append @renderTopic(topic)
            else
                d3.layout.cloud().size([
                  500
                  500
                ]).words(@collection.map((topic) ->
                  text: topic.get('label')
                  size: 100 / helpers.calculateTopicSize(topic)
                  color: helpers.calculateTopicColor(topic)
                )).padding(5).rotate(=>
                  @random(1, 2) * 30
                ).font("PT Mono").fontSize((d) ->
                  d.size
                ).on("end", _.bind(@draw, @)).start()

        showTopicInfo: (e)->
            e.preventDefault()
            topicUrlSegment = $(e.currentTarget).data 'topic-urlsegment'
            # delegate showing of topic info to TopicInfoView instance
            ventr.trigger 'TopicInfoView:show', topicUrlSegment

        draw: (words) ->
          colors = 
            'green': '#0f0'
            'grey': '#bbb'
            'red': '#f00'

          d3.select(@el)
          .append("svg")
          .attr("width", 500)
          .attr("height", 500)
          .append("g")
          .attr("transform", "translate(150,150)")
          .selectAll("text")
          .data(words)
          .enter()
          .append("text")
          .style("font-size", (d) ->
            d.size + "px"
          ).style("font-family", "PT Mono").style("fill", (d, i) ->
            colors[d.color]
          ).attr("text-anchor", "middle").attr("transform", (d) ->
            "translate(" + [
              d.x
              d.y
            ] + ")rotate(" + d.rotate + ")"
          ).text (d) ->
            d.text

        random: (min, max) ->
            Math.random() * (max - min) + min