Backbone = require('backbone')
JST = require('jst')

class EncodingView extends Backbone.View
  template: JST['encoding']

  render: ->
    $(@el).html(@template())
    this

root = exports ? window
root.EncodingView = EncodingView