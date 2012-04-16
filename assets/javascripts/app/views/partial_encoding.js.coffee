class PartialEncoding extends Backbone.View
  template: JST['area']
  events:
    "click #next" : 'nextIteration'

  initialize: (options) ->
    @resultCode = options.code
    checked = @resultCode.positions.checked
    @positions = _(checked).values()
    @bits = _(checked).keys()
    @code = new HammingCode(@resultCode.origin)

  render: ->
    $(@el).html(@template(@toJson()))
    @nextIteration()
    this

  toJson: ->
    origin: @joinValues(@resultCode.origin)
    result: @joinValues(@resultCode.encode().word)

  joinValues: (value) -> _(value).join("")

  nextIteration: ->
    unless @nodeIsEmpty()
      partial = new Partial( @code.word, @positions[0], @el )
      current_positions = @positions.shift()
      parity_bit = @bits.shift()
      bit = @code.encodeByPositions(current_positions, parity_bit)
      partial.attachStatistics(bit, parity_bit, current_positions)
      partial.render()

  nodeIsEmpty: ->
    _(@positions).isEmpty() and _(@bits).isEmpty()

root = exports ? window
root.PartialEncoding = PartialEncoding