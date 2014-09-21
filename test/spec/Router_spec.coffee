# global define, describe, it, expect, sinon
"use strict"
define [
    'backbone'
    'scripts/Router'
], (Backbone, Router)->

    describe 'Router', ->

        beforeEach ->
            @router = new Router
            @routeSpy = sinon.spy()
            
            try
                Backbone.history.start
                    silent: yes

            @router.navigate 'elsewhere'

        after ->
            @router.navigate ''

        it 'fires the index route with a blank hash', ->
            @router.bind 'route:index', @routeSpy
            @router.navigate '', { trigger: yes }
            expect(@routeSpy.calledOnce).to.be.true
            expect(@routeSpy.calledWith()).to.be.true

        it 'fires the showInfoRoute with a non blank hash', ->
            @router.bind 'route:showWordInfo', @routeSpy
            @router.navigate '#1234_test', { trigger: yes }
            expect(@routeSpy.calledOnce).to.be.true
            expect(@routeSpy.calledWith('1234_test')).to.be.true
