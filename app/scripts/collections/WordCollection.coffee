define [
    'backbone',
    'models/WordModel'
], (Backbone, WordModel)->
    class WordCollection extends Backbone.Collection

        model: WordModel

        parse: (data)->
            data.topics