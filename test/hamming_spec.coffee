require('./helper.js')
{HammingCode} = require('../assets/javascripts/libs/hamming.js.coffee')

describe 'HammingCode', ->
  positions_to_check = {
    '1': [ 1, 3, 5, 7, 9, 11, 13, 15, 17 ],
    '2': [ 2, 3, 6, 7, 10, 11, 14, 15, 18 ],
    '4': [ 4, 5, 6, 7, 12, 13, 14, 15, 20 ],
    '8': [ 8, 9, 10, 11, 12, 13, 14, 15, 24 ]
  }

  beforeEach -> @subject = new HammingCode([1, 0, 0, 1, 1, 0, 1, 0])

  describe 'має початкове значення', ->
    it "для інформаційних позицій", -> (@subject.parity.bits).should.eql([1, 2, 4, 8])
    it "обмеження в підрахуванні позицій", -> (@subject.positions.limit).should.eql(16)

  describe 'для слова', ->

    it "підраховує інформаційні позиції -> [null, null, 1, null, 0, 0, 1, null, 1, 0, 1, 0]", ->
      (@subject.word).should.eql([null, null, 1, null, 0, 0, 1, null, 1, 0, 1, 0])

    it "кодує, і отримує -> [0,1,1,1,0,0,1,0,1,0,1,0]", ->
      @subject.encode()
      (@subject.word).should.eql([0,1,1,1,0,0,1,0,1,0,1,0])

    it "підраховує позиції перебору", ->
      (@subject.positions.checked).should.eql(positions_to_check)

    console.log "
        Cлово: 10011010\n
        Інформаційні позиції: [1, 2, 4, 8]\n
        Обмеження в підрахуванні позицій: 16\n
        Позиції перебору:\n
                  '1' => [ 1, 3, 5, 7, 9, 11, 13, 15, 17 ],\n
                  '2' => [ 2, 3, 6, 7, 10, 11, 14, 15, 18 ],\n
                  '4' => [ 4, 5, 6, 7, 12, 13, 14, 15, 20 ],\n
                  '8' => [ 8, 9, 10, 11, 12, 13, 14, 15, 24 ]
    "