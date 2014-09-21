# global define, describe, it, expect, sinon
"use strict"
define [
    'jquery'
    'underscore'
    'backbone'
    'fixtures'
    'scripts/Router'
    'collections/WordCollection'
    'views/WordInfoView'
], ($, _, Backbone, fixtures, Router, WordCollection, WordInfoView)->

    describe 'WordInfoView', ->
        beforeEach ->
            @words = new WordCollection fixtures, { randomSort: off }

            try
                @closeSpy = sinon.spy WordInfoView.prototype, 'close'

            @wordInfo = new WordInfoView
                collection: @words

            @router = new Router

            try
                Backbone.history.start
                    silent: yes

        after ->
            @router.navigate '', { trigger: yes }
            @wordInfo.remove()

        it 'shows info about a word when a route with a valid word id is fired', ->
            word = @words.first()
            wordId = word.id
            
            @router.navigate wordId, { trigger: yes }
            
            rendered =
                title: @wordInfo.$('.modal-title').text()
                mentions: 
                    total: @wordInfo.$('.list-group-item:eq(0) span:eq(0)').text()
                    positive: @wordInfo.$('.list-group-item:eq(1) span:eq(0)').text()
                    neutral: @wordInfo.$('.list-group-item:eq(2) span:eq(0)').text()
                    negative: @wordInfo.$('.list-group-item:eq(3) span:eq(0)').text()

            expect(rendered.title).to.be.equal word.get('label')
            expect(parseInt(rendered.mentions.total)).to.be.equal word.get('volume')

        it 'gets closed when the close button is clicked', ->
            word = @words.first()
            wordId = word.id
            
            @router.navigate ''
            @router.navigate wordId, { trigger: yes }
            @wordInfo.$('.js-word-info-close').click()

            expect(@closeSpy.called).to.be.true

        it 'gets closed when the index route is fired', ->
            @router.navigate ''
            expect(@closeSpy.called).to.be.true