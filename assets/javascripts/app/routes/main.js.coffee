class MainRoutes extends Backbone.Router
  routes:
    '' : 'index'

  initialize: -> @container = $('#container')

  index: ->
    view = new MainEncoding(el: @container)
    view.render()

root = exports ? window
root.MainRoutes = MainRoutes