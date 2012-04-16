class Integer
  @isEven: (num) ->
    num % 2 == 0

  @progression: (times, rank, start = 1) ->
    range = _.range(times)
    _(range).map (el) -> Math.pow( (start * rank), el )

class Parity
  constructor: (@word) ->
    @progression_rate = @get_rate()
    @bits = @calculate_bits()

  get_rate: ->
    rate = Math.sqrt(@word.length)
    rate = parseInt(rate.toFixed()) + 1

  calculate_bits: ->
    Integer.progression(@progression_rate,2)

  get_word: ->
    _(@bits).each (position) =>
      @word.splice(position - 1, 0, null)
    @word

class Positions
  constructor: (@parity) ->
    @limit = @get_limit()
    @checked = @get_positions()

  get_limit: ->
    rate = @parity.progression_rate + 1
    progression = Integer.progression(rate,2)
    _.last(progression)

  get_positions: ->
    positions = {}
    _(@parity.bits).each (bit) =>
      positions[bit] = @define_positions( [bit], bit )
    positions

  define_positions: (container, bit) ->
    el = bit
    while el < @limit
      el += @step(container, bit)
      container.push(el)
    container

  step: (container, bit) ->
    if (container.length % bit == 0) then (bit + 1) else 1

class HammingCode
  constructor: (@origin) ->
    @parity = new Parity(_(@origin).clone())
    @positions = new Positions(@parity)
    @word = @parity.get_word()

  encode: ->
    _(@positions.checked).each (positions, bit) =>
      @encodeByPositions(positions, bit)
    this

  encodeByPositions: (positions, bit) ->
    bits = @fetch_bits(positions)
    result = @calculate_positive_bit(bits)
    @word[bit - 1] = @get_result_bit(result)

  fetch_bits: (positions) ->
    _(positions).map (position) => @word[position - 1]

  calculate_positive_bit: (bits) ->
    _(bits).filter (num) -> num == 1

  get_result_bit: (result) ->
    if Integer.isEven(result.length) then 0 else 1

root = exports ? window
root.HammingCode = HammingCode
