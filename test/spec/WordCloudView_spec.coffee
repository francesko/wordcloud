#global define, describe, it, expect, sinon
"use strict"
define [
    'underscore'
    'backbone'
    'fixtures'
    'models/WordModel'
    'collections/WordCollection'
    'views/WordCloudView'
], (_, Backbone, fixtures, WordModel, WordCollection, WordCloudView) ->
  words = undefined
  wordCloud = undefined

  describe 'WordCloudView', ->
    beforeEach ->
        words = new WordCollection
        wordCloud = new WordCloudView
            collection: words

    it 'should be rendered whenever the collection is reset', ->
        renderSpy = sinon.spy WordCloudView.prototype, 'render'
        wordCloud = new WordCloudView
            collection: words

        wordCloud.collection.reset fixtures
        expect(renderSpy.called).to.be.true

    it 'should render words with sentimentScore greater than 60 in green', ->
        word = new WordModel
            sentimentScore: 61

        fontColor = wordCloud.calculateWordColor word
        expect(fontColor).to.equal('green')

    it 'should render words with sentimentScore between 60 and 40 in grey', ->
        word = new WordModel
            sentimentScore: 60

        fontColor = wordCloud.calculateWordColor word
        expect(fontColor).to.equal('grey')

        word.set 'sentimentScore', 40

        fontColor = wordCloud.calculateWordColor word
        expect(fontColor).to.equal('grey')

    it 'should render words with sentimentScore less than 40 in red', ->
        word = new WordModel
            sentimentScore: 39

        fontColor = wordCloud.calculateWordColor word
        expect(fontColor).to.equal('red')

    it 'should render words as big as their popularity', ->
        # fixtures are sorted by popularity in descendant order
        words.reset fixtures

        # six fixtures, one for each level of popularity [1-6]
        words.forEach (word, index)->
            expect(wordCloud.calculateWordSize(words.at(index))).to.equal(index + 1)




