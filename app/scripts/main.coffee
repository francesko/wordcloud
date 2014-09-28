'use strict'

require.config
  shim: {
    bootstrap:
      deps: ['jquery'],
      exports: 'jquery'
    d3cloud:
      deps: ['d3']
      exports: 'd3cloud'
  }
  paths:
    jquery: '../bower_components/jquery/dist/jquery'
    backbone: '../bower_components/backbone/backbone'
    underscore: '../bower_components/lodash/dist/lodash'
    bootstrap: '../bower_components/sass-bootstrap/dist/js/bootstrap'
    text: '../bower_components/requirejs-text/text'
    d3: '../bower_components/d3/d3'
    d3cloud: '../bower_components/d3-cloud/d3.layout.cloud'

require [
  'backbone'
  'text!data/topics.json'
  'Router'
  'collections/Topics'
  'views/TopicsView',
  'views/TopicInfoView'
], (Backbone, topicsJSON, Router, Topics, TopicsView, TopicInfoView) ->

  # initialize app instances

  topics = new Topics { randomSort: on } # set random sort on
  
  new TopicsView
    el: '.js-topics'
    collection: topics

  new TopicInfoView
    collection: topics

  # parse JSON text and insert items into collection
  topics.reset JSON.parse(topicsJSON), { parse: on }

  new Router()
  
  Backbone.history.start()
