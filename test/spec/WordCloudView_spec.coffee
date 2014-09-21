 # global define, describe, it, expect, sinon
"use strict"
define [
    'jquery'
    'fixtures'
    'models/WordModel'
    'collections/WordCollection'
    'views/WordCloudView'
], ($, fixtures, WordModel, WordCollection, WordCloudView) ->

  describe 'WordCloudView', ->
    beforeEach ->
        @words = new WordCollection
        @wordCloud = new WordCloudView
            collection: @words
        @words.reset fixtures

    it 'works with a collection of words', ->
        expect(@wordCloud.collection).to.be.an.instanceOf WordCollection

    it 'renders whenever the collection is reset', ->
        renderSpy = sinon.spy WordCloudView.prototype, 'render'
        @wordCloud = new WordCloudView
            collection: @words

        @wordCloud.collection.reset fixtures
        expect(renderSpy.called).to.be.true

    it 'renders words with sentimentScore greater than 60 in green', ->
        word = @words.at(0)
        $word = $(@wordCloud.renderWord(word))
        expect($word.hasClass('text_green')).to.be.true

    it 'renders words with sentimentScore between 60 and 40 in grey', ->
        word = @words.at(1)
        $word = $(@wordCloud.renderWord(word))
        expect($word.hasClass('text_grey')).to.be.true

        word = @words.at(2)
        $word = $(@wordCloud.renderWord(word))
        expect($word.hasClass('text_grey')).to.be.true

    it 'renders words with sentimentScore less than 40 in red', ->
        word = @words.at(4)
        $word = $(@wordCloud.renderWord(word))
        expect($word.hasClass('text_red')).to.be.true

    it 'renders words in different sizes according to their popularity', ->
        # fixtures are sorted by popularity in descendant order
        # six fixtures, one for each level of popularity [1-6]
        @words.forEach (word, index)=>
            $word = $(@wordCloud.renderWord(word))
            expect($word.hasClass('text_size-' + (index + 1))).to.be.true




