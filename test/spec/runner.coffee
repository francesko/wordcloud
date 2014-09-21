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
    models: '../../scripts/models'
    collections: '../../scripts/collections'
    views: '../../scripts/views'
    templates: '../../scripts/templates'
    ventr: '../../scripts/ventr'
    jquery: '../../bower_components/jquery/dist/jquery'
    backbone: '../../bower_components/backbone/backbone'
    underscore: '../../bower_components/lodash/dist/lodash'
    text: '../../bower_components/requirejs-text/text'

specs = [
  "WordCollection_spec"
  "WordCloudView_spec"
]

require specs, ->
  mocha.run()
