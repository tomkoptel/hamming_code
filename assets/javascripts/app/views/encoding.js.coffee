class EncodingView extends Backbone.View
  template: JST['encoding']
  events:
    'submit' : 'newWord'
  render: ->
    $(@el).html(@template())
    @input = $('form input[name=word]')
    @area = $('ul')
    this

  newWord: (event) ->
    event.preventDefault()
    parser = new WordParser(@input)
    parser.parse().then(
      (word) => @appendEncodedValue(word)
      (error) -> alert(error.message)
    )

  appendEncodedValue: (word) ->
    hammingCode = new HammingCode(word)
    encodedValue = hammingCode.encode().word
    encodedValue = _(encodedValue).join("")

    @area.append("<li>Origin: #{@input.val()} Encoded: #{encodedValue}</li>")
    @input.val('')
    $('body #container').append(@area)

root = exports ? window
root.EncodingView = EncodingView