# global define, describe, it, expect, sinon
"use strict"
define [
    'fixtures'
    'utils/helpers'
    'models/Topic'
    'collections/Topics'
], (fixtures, helpers, Topic, Topics) ->

  describe 'Topics collection', ->
    beforeEach ->
        @topics = new Topics
        @topics.reset fixtures

    it 'contains instances of Topic model', ->
        expect(@topics.first()).to.be.an.instanceof Topic

    it 'caches the max popularity value when content is reset', ->
        max1 = @topics.popularity.max
        @topics.reset _.rest(fixtures)
        max2 = @topics.popularity.max
        expect(max1).to.not.equal(max2)

    it 'finds a topic by its url segment', ->
        topic = @topics.first()
        urlSegment = helpers.generateUrlSegment topic
        expect(@topics.findByUrlSegment(urlSegment)).to.be.equal topic