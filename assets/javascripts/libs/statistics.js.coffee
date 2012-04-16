class Statistics
  constructor: (@options) ->
    @old_word = new WordView(@options.old.word, @options.current.positions)
    @new_word = new WordView(@options.new.word, @options.current.positions)

  render: ->
    @el = $("<li></li>")
    @el.append(@head())
    @el.append('</br>')
    @el.append(@old_word.render().el)
    @el.append(@body())
    @el.append(@new_word.render().el)
    this

  head: ->
    $("<span>Позиція #{@options.current.parity_bit} провіряємо #{@options.current.positions}:</span>")

  body: ->
    type = if @options.current.bit is 0 then "парнa" else "не парнa"
    $("<span> - це #{type} нерівність, отже біт підстановки #{@options.current.bit} : </span>")

root = exports ? window
root.Statistics = Statistics
