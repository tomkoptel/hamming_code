class MainRoutes extends Backbone.Router
  routes:
    '' : 'index'

  initialize: -> @container = $('#container')

  index: ->
    view = new EncodingView(el: @container)
    view.render()

root = exports ? window
root.MainRoutes = MainRoutes