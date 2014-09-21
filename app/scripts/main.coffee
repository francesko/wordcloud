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
  'collections/Topics'
  'views/TopicsView',
  'views/TopicInfoView'
], (Backbone, topicsJSON, Router, Topics, TopicsView, TopicInfoView) ->

  topics = new Topics { randomSort: on }
  
  new TopicsView
    el: '.js-topics'
    collection: topics

  new TopicInfoView
    collection: topics

  topics.reset JSON.parse(topicsJSON), { parse: on }

  new Router()
  
  Backbone.history.start()
