# global define, describe, it, expect, sinon
"use strict"
define [
    'fixtures'
    'models/WordModel'
    'collections/WordCollection'
], (fixtures, WordModel, WordCollection) ->

  describe 'WordCollection', ->
    beforeEach ->
        @words = new WordCollection
        @words.reset fixtures

    it 'contains instances of WordModel', ->
        expect(@words.first()).to.be.an.instanceof WordModel

    it 'caches the max popularity value when content is reset', ->
        max1 = @words.popularity.max
        @words.reset _.rest(fixtures)
        max2 = @words.popularity.max
        expect(max1).to.not.equal(max2)