require('./helper.js')
{WordParser} = require('../assets/javascripts/libs/word_parser.js.coffee')
jsdom = require('jsdom')
doc = jsdom.jsdom('<html><body></body></html>', jsdom.level(1, 'core'))
input = $("<input name='word' value='1, 0, 0, 1, 1, 0, 1, 0'/>")
$('body').append(input)

describe 'WordParser', ->
  beforeEach -> @subject = new WordParser(input)

  describe 'початкові значення', ->
    expectThat -> (@subject.el).should.eql(input)
    expectThat -> (@subject.word).should.eql('1, 0, 0, 1, 1, 0, 1, 0')

  describe "#parse", ->
    it "повинен розібрати слово '1, 0, 0, 1, 1, 0, 1, 0'", ->
      @subject.parse().then (word) ->
        (word).should.eql([1, 0, 0, 1, 1, 0, 1, 0])

    it "повинен розібрати слово '10011010'", ->
      @subject.word = '10011010'
      @subject.parse().then (word) ->
        (word).should.eql([1, 0, 0, 1, 1, 0, 1, 0])

  describe "для слова ''", ->
    it "має підтвердити статус Empty", ->
      @subject.word = ''
      (@subject.isEmpty()).should.be.true

  describe "#covert", ->
    it "не сможе сконвертувати '1a1ff'", ->
      @subject.word = '1a1ff'
      -> (@subject.convert()).should.throw('Неможливо конвертувати біт!')
