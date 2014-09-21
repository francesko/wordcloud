 # global define, describe, it, expect, sinon
"use strict"
define [
    'jquery'
    'fixtures'
    'models/Topic'
    'collections/Topics'
    'views/TopicsView'
], ($, fixtures, Topic, Topics, TopicsView) ->

  describe 'TopicsView', ->
    beforeEach ->
        @topics = new Topics

        try
            @renderSpy = sinon.spy TopicsView.prototype, 'render'

        @topicsView = new TopicsView
            collection: @topics

        @topics.reset fixtures

    it 'works with a collection of topics', ->
        expect(@topicsView.collection).to.be.an.instanceOf Topics

    it 'renders whenever the collection is reset', ->
        @topics.reset fixtures
        expect(@renderSpy.called).to.be.true

    it 'renders topics with sentimentScore greater than 60 in green', ->
        topic = @topics.at(0)
        $topic = $(@topicsView.renderTopic(topic))
        expect($topic.hasClass('text_green')).to.be.true

    it 'renders topics with sentimentScore between 60 and 40 in grey', ->
        topic = @topics.at(1)
        $topic = $(@topicsView.renderTopic(topic))
        expect($topic.hasClass('text_grey')).to.be.true

        topic = @topics.at(2)
        $topic = $(@topicsView.renderTopic(topic))
        expect($topic.hasClass('text_grey')).to.be.true

    it 'renders topics with sentimentScore less than 40 in red', ->
        topic = @topics.at(4)
        $topic = $(@topicsView.renderTopic(topic))
        expect($topic.hasClass('text_red')).to.be.true

    it 'renders topics in different sizes according to their popularity', ->
        # fixtures are sorted by popularity in descendant order
        # six fixtures, one for each level of popularity [1-6]
        @topics.forEach (topic, index)=>
            $topic = $(@topicsView.renderTopic(topic))
            expect($topic.hasClass('text_size-' + (index + 1))).to.be.true




