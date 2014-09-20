define [
    'underscore'
    'backbone'
], (_, Backbone)->
    class WordModel extends Backbone.Model

        idAttribute: 'id'

        parse: (data)->
            attrs = ['id', 'label', 'volume', 'sentiment', 'sentimentScore']
            attrs.unshift data
            _.pick.apply _, attrs