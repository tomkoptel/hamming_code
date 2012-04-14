_ = require('underscore')._
class HammingCode
  constructor: (@word) ->
    @check_positions = {}
    @parity_bits = @get_parity_bits()
    @limit = _.last(@progression(@max_rank,2)) * 2

  get_parity_bits: ->
    @calculate_max_rank()
    @progression(@max_rank,2)

  calculate_max_rank: ->
    @max_rank = Math.sqrt(@word.length)
    @max_rank = parseInt(@max_rank.toFixed()) + 1

  progression: (times, rank, start = 1) ->
    range = _.range(times)
    _(range).map (el) -> Math.pow( (start * rank), el )

  insert_parity_positions: ->
    _(@parity_bits).each (position) =>
      @word.splice(position - 1, 0, null)

  calculate_check_positions: ->
    _(@parity_bits).each (bit) =>
      @check_positions[bit] = @define_positions( [bit],bit )

  define_positions: (container, bit) ->
    last = bit
    while last < @limit
      last += @step(container, bit)
      container.push(last)
    container

  step: (container, bit) ->
    if (container.length % bit == 0) then (bit + 1) else 1

  encode: ->
    @insert_parity_positions()
    @calculate_check_positions()
    _(@check_positions).each (positions, bit) =>
      parity = _(positions).map (position) => @word[position - 1]
      result = _(parity).filter (num) -> num == 1
      @word[bit - 1] = if @isEven(result.length) then 0 else 1

  isEven: (num) ->
    num % 2 == 0

root = exports ? window
root.HammingCode = HammingCode
