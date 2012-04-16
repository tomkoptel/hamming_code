class PartialEncoding extends Backbone.View
  template: JST['area']
  events:
    "click #next" : 'nextIteration'
    "click #start" : 'goToIndex'

  initialize: (options) ->
    @resultCode = options.code
    checked = @resultCode.positions.checked
    @positions = _(checked).values()
    @bits = _(checked).keys()
    @code = new HammingCode(@resultCode.origin)

  render: ->
    $(@el).html(@template(@toJson()))
    @generateArea()
    @nextIteration()
    this

  toJson: ->
    origin: @joinValues(@resultCode.origin)
    result: @joinValues(@resultCode.encode().word)

  joinValues: (value) -> _(value).join("")

  generateArea: ->
    @area = $('<ul></ul>')
    $(@el).append(@area)

  nextIteration: ->
    unless @nodeIsEmpty()
      old_word = _(@code.word).clone()
      current_positions = @positions.shift()
      parity_bit = @bits.shift()
      bit = @code.encodeByPositions(current_positions, parity_bit)
      options =
        old:
          word: old_word
        new:
          word: @code.word
        current:
          bit: bit
          parity_bit: parity_bit
          positions: current_positions
      statistics = new Statistics(options)
      @area.append(statistics.render().el)


  nodeIsEmpty: ->
    _(@positions).isEmpty() and _(@bits).isEmpty()

  goToIndex: ->
    window.location = '/'

root = exports ? window
root.PartialEncoding = PartialEncoding