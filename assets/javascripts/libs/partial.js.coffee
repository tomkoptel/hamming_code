class Partial
  constructor: (@word, @positions, @el) ->
    @spans = []
    @container = $('<div></div>')
    @statistic = $('<span></span>')

  attachStatistics: (bit, parity_bit, current_positions) ->
    type = if bit is 0 then "Парнa" else "Не парнa"
    sentence = "Позиція #{parity_bit} провіряємо #{current_positions}:\n #{type} нерівність отже біт підстановки #{bit} : "
    @statistic.html(sentence)

  render: ->
    @generateSpans()
    @decorateSpans()
    @attachSpans()


  generateSpans: ->
    _(@word).each (bit, index) =>
      label = if _(bit).isNull() then "?" else bit
      @spans.push($("<span data-position='#{index+1}'>#{label}</span>")[0])

  decorateSpans: ->
    _(@positions).each (position) =>
      span = _(@spans).find (span) -> $(span).data('position') is position
      $(span).css("color","red") unless $(span).text() is "?"

  attachSpans: ->
    @container.append(@spans)
    @container.append(@statistic)
    $(@el).append(@container)

root = exports ? window
root.Partial = Partial