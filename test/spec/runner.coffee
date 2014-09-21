"use strict"

console.log 'test runner'
console.log requirejs.s.contexts._.config.baseUrl

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
