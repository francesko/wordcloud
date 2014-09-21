"use strict"

require.config
  baseUrl: 'spec/'
  shim: {
    bootstrap:
      deps: ['jquery'],
      exports: 'jquery'
  }
  paths:
    scripts: '../../scripts'
    utils: '../../scripts/utils'
    models: '../../scripts/models'
    collections: '../../scripts/collections'
    views: '../../scripts/views'
    templates: '../../scripts/templates'
    ventr: '../../scripts/ventr'
    jquery: '../../bower_components/jquery/dist/jquery'
    backbone: '../../bower_components/backbone/backbone'
    underscore: '../../bower_components/lodash/dist/lodash'
    bootstrap: '../bower_components/sass-bootstrap/dist/js/bootstrap'
    text: '../../bower_components/requirejs-text/text'

specs = [
  'Router_spec'
  'Topics_spec'
  'TopicsView_spec'
  'TopicInfoView_spec'
]

require specs, ->
  mocha.run()
