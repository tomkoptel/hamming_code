require('./helper.js')
{WordParser} = require('../assets/javascripts/libs/word_parser.js.coffee')
jsdom = require('jsdom')
doc = jsdom.jsdom('<html><body></body></html>', jsdom.level(1, 'core'))
input = $("<input name='word' value='1, 0, 0, 1, 1, 0, 1, 0'/>")
$('body').append(input)

describe 'WordParser', ->
  beforeEach -> @subject = new WordParser(input)

  describe 'basic attributes', ->
    expectThat -> (@subject.el).should.eql(input)
    expectThat -> (@subject.word).should.eql('1, 0, 0, 1, 1, 0, 1, 0')

  describe "#parse", ->
    it "should parse '1, 0, 0, 1, 1, 0, 1, 0'", ->
      @subject.parse().then (word) ->
        (word).should.eql([1, 0, 0, 1, 1, 0, 1, 0])

    it "should parse '10011010'", ->
      @subject.word = '10011010'
      @subject.parse().then (word) ->
        (word).should.eql([1, 0, 0, 1, 1, 0, 1, 0])

  describe "@word is ''", ->
    it "should be Empty", ->
      @subject.word = ''
      (@subject.isEmpty()).should.be.true

  describe "#covert", ->
    it "should not convert '1a1ff'", ->
      @subject.word = '1a1ff'
      -> (@subject.convert()).should.throw('Неможливо конвертувати біт!')
