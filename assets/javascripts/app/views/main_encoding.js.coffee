class MainEncoding extends Backbone.View
  template: JST['encoding']
  events:
    'submit' : 'newWord'

  render: ->
    $(@el).html(@template())
    @input = $('form input[name=word]')
    this

  newWord: (event) ->
    event.preventDefault()
    parser = new WordParser(@input)
    parser.parse().then(
      (word) => @encodeValue(word)
      (error) -> alert(error.message)
    )

  encodeValue: (word) ->
    hammingCode = new HammingCode(word)
    view = new PartialEncoding(el: $(@el), code: hammingCode)
    view.render()

root = exports ? window
root.MainEncoding = MainEncoding