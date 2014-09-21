#global define, describe, it, expect, sinon
"use strict"
define [
    'jquery'
    'underscore'
    'backbone'
    'fixtures'
    'models/WordModel'
    'collections/WordCollection'
    'views/WordCloudView'
], ($, _, Backbone, fixtures, WordModel, WordCollection, WordCloudView) ->
  words = undefined
  wordCloud = undefined

  describe 'WordCloudView', ->
    beforeEach ->
        words = new WordCollection
        wordCloud = new WordCloudView
            collection: words
        words.reset fixtures

    it 'should be rendered whenever the collection is reset', ->
        renderSpy = sinon.spy WordCloudView.prototype, 'render'
        wordCloud = new WordCloudView
            collection: words

        wordCloud.collection.reset fixtures
        expect(renderSpy.called).to.be.true

    it 'should render words with sentimentScore greater than 60 in green', ->
        word = words.at(0)
        $word = $(wordCloud.renderWord(word))
        expect($word.hasClass('text_green')).to.be.true

    it 'should render words with sentimentScore between 60 and 40 in grey', ->
        word = words.at(1)
        $word = $(wordCloud.renderWord(word))
        expect($word.hasClass('text_grey')).to.be.true

        word = words.at(2)
        $word = $(wordCloud.renderWord(word))
        expect($word.hasClass('text_grey')).to.be.true

    it 'should render words with sentimentScore less than 40 in red', ->
        word = words.at(4)
        $word = $(wordCloud.renderWord(word))
        expect($word.hasClass('text_red')).to.be.true

    it 'should render words as big as their popularity', ->
        # fixtures are sorted by popularity in descendant order
        # six fixtures, one for each level of popularity [1-6]
        words.forEach (word, index)->
            $word = $(wordCloud.renderWord(word))
            expect($word.hasClass('text_size-' + (index + 1))).to.be.true




