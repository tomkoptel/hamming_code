class WordParser
  constructor: (@el) ->
    @word = @el.val()

  parse: ->
    defered = $.Deferred()
    if @isEmpty()
      defered.reject( new Error('Введіть кодове слово!') )
    else
      @convertWord(defered)
    defered.promise()

  isEmpty: ->  @word.length is 0

  convertWord: (defered) ->
    try
      word = @splitWord()
      word = _(word).map (bit) => @isConvertable(bit)
      defered.resolve(word)
    catch error
      defered.reject(error)

  splitWord: ->
    if _.str.include(@word, ',')
      _.str.words(@word, ',')
    else
    _.str.chars(@word)

  isConvertable: (bit) ->
    result = parseInt(bit)
    if _(result).isNaN()
      throw new Error('Неможливо конвертувати біт!')
    result

root = window ? exports
root.WordParser = WordParser