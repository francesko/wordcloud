#/*global require*/
'use strict'

require.config
  shim: {
    bootstrap:
      deps: ['jquery'],
      exports: 'jquery'
  }
  paths:
    jquery: '../bower_components/jquery/dist/jquery'
    backbone: '../bower_components/backbone/backbone'
    underscore: '../bower_components/lodash/dist/lodash'
    bootstrap: '../bower_components/sass-bootstrap/dist/js/bootstrap'
    text: '../bower_components/requirejs-text/text'

require [
  'backbone'
  'text!data/topics.json'
  'Router'
  'collections/WordCollection'
  'views/WordCloudView',
  'views/WordInfoView'
], (Backbone, topics, Router, WordCollection, WordCloudView, WordInfoView) ->
  topics = JSON.parse topics

  words = new WordCollection { randomSort: on }
  
  new WordCloudView
    el: '.js-word-cloud'
    collection: words

  new WordInfoView
    collection: words

  words.reset topics, { parse: on }

  new Router()
  
  Backbone.history.start()
