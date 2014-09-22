# global define, describe, it, expect, sinon
"use strict"
define [
    'jquery'
    'fixtures'
    'scripts/Router'
    'collections/Topics'
    'views/TopicInfoView'
], ($, fixtures, Router, Topics, TopicInfoView)->

    describe 'TopicInfoView', ->
        before ->
            @topics = new Topics fixtures, { randomSort: off }

            try
                @closeSpy = sinon.spy TopicInfoView.prototype, 'close'

            window.test = @topicInfoView = new TopicInfoView
                collection: @topics

            @router = new Router

            try
                Backbone.history.start
                    silent: yes

        after ->
            @router.navigate '', { trigger: yes }
            @topicInfoView.remove()

        it 'shows info about a topic when a route with a valid topic id is fired', ->
            topic = @topics.first()
            topicId = topic.id
            
            @router.navigate topicId, { trigger: yes }
            
            rendered =
                title: @topicInfoView.$('.modal-title').text()
                mentions: 
                    total: @topicInfoView.$('.list-group-item:eq(0) span:eq(0)').text()
                    positive: @topicInfoView.$('.list-group-item:eq(1) span:eq(0)').text()
                    neutral: @topicInfoView.$('.list-group-item:eq(2) span:eq(0)').text()
                    negative: @topicInfoView.$('.list-group-item:eq(3) span:eq(0)').text()

            expect(rendered.title).to.be.equal topic.get('label')
            expect(parseInt(rendered.mentions.total)).to.be.equal topic.get('volume')
            expect(parseInt(rendered.mentions.positive)).to.be.equal topic.get('sentiment').positive
            expect(parseInt(rendered.mentions.neutral)).to.be.equal topic.get('sentiment').neutral
            expect(parseInt(rendered.mentions.negative)).to.be.equal topic.get('sentiment').negative

        it 'gets closed when the close button is clicked', ->
            topic = @topics.first()
            topicId = topic.id
            
            @router.navigate ''
            @router.navigate topicId, { trigger: yes }
            @topicInfoView.$('.js-topic-info-close').click()

            expect(@closeSpy.called).to.be.true

        it 'gets closed when the index route is fired', ->
            @router.navigate ''
            expect(@closeSpy.called).to.be.true