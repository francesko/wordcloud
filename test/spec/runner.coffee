"use strict"

console.log 'test runner'

require.config
  baseUrl: "../../.tmp/scripts/"
  paths:
    jquery: "../bower_components/jquery/dist/jquery"
    backbone: "../bower_components/backbone/backbone"
    underscore: "../bower_components/lodash/dist/lodash"

  shim:
    underscore:
      exports: "_"

    jquery:
      exports: "$"

    backbone:
      deps: [
        "underscore"
        "jquery"
      ]
      exports: "Backbone"

specs = [
  "spec/WordCollection.spec.js"
  "spec/WordCloudView.spec.js"
]

require specs, ->
  mocha.run()
