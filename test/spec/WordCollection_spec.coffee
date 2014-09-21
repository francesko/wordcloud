#global define, describe, it, expect 
"use strict"
define [
    'fixtures'
    'models/WordModel'
    'collections/WordCollection'
], (fixtures, WordModel, WordCollection) ->
  words = undefined

  beforeEach ->
    words = new WordCollection
    words.reset fixtures

  describe 'WordCollection', ->
    it 'should contain instances of WordModel', ->
        expect(words.first()).to.be.an.instanceof(WordModel)

    it 'should cache the max popularity value when the content is reset', ->
        max1 = words.popularity.max
        words.reset _.rest(fixtures)
        max2 = words.popularity.max
        expect(max1).to.not.equal(max2)