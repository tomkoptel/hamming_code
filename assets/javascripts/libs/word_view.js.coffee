class WordView
  constructor: (@word, @positions) ->
    @spans = []
    @el = $('<span></span>')

  render: ->
    @generateSpans()
    @decorateSpans()
    @attachSpans()
    this

  generateSpans: ->
    _(@word).each (bit, index) =>
      label = if _(bit).isNull() then "?" else bit
      @spans.push($("<span data-position='#{index+1}'>#{label}</span>")[0])

  decorateSpans: ->
    _(@positions).each (position) =>
      span = _(@spans).find (span) -> $(span).data('position') is position
      $(span).css("color","red") unless $(span).text() is "?"

  attachSpans: ->
    @el.append(@spans)

root = exports ? window
root.WordView = WordView