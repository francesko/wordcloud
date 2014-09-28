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

        renderTopic: (topic, asObject)->
            data = topic.toJSON()
            # set rendering attributes
            data.fontColor = helpers.calculateTopicColor topic
            data.fontSize = helpers.calculateTopicSize topic
            data.urlSegment = helpers.generateUrlSegment topic
            
            if asObject
                data
            else
                @template data

        render: ->
            @$el.empty()

            if not window.Modernizr or not Modernizr.svg
                # no svg fallback
                @collection.forEach (topic)=>
                    @$el.append @renderTopic(topic)
            else
                d3.layout.cloud().size([
                  600
                  600
                ]).words(@collection.map((topic)=>
                  data = @renderTopic(topic, yes)
                  text: data.label
                  color: data.fontColor
                  size: 100 / data.fontSize
                  urlSegment: data.urlSegment
                ))
                .padding(5).rotate(=>
                  @random(-1, 1) * 30
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
            'green': '#458b00'
            'grey': '#a9a9a9'
            'red': '#cd0000'

          d3.select(@el)
          .append("svg")
          .attr("width", 600)
          .attr("height", 600)
          .append("g")
          .attr("transform", "translate(250,250)")
          .selectAll("text")
          .data(words)
          .enter()
          .append("text")
          .attr('class', 'js-topic')
          .style("font-size", (d) ->
            d.size + "px"
          )
          .style("font-family", "PT Mono")
          .style("fill", (d, i) ->
            colors[d.color]
          )
          .attr('data-topic-urlsegment', (d)->
            d.urlSegment
          )
          .attr("text-anchor", "middle").attr("transform", (d) ->
            "translate(" + [
              d.x
              d.y
            ] + ")rotate(" + d.rotate + ")"
          ).text (d) ->
            d.text

        random: (min, max) ->
            Math.random() * (max - min) + min