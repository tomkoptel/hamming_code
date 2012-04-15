require('expectThat.mocha')
{HammingCode} = require('../assets/javascripts/lib/hamming.js.coffee')

describe 'HammingCode', ->
  positions_to_check = {
    '1': [ 1, 3, 5, 7, 9, 11, 13, 15, 17 ],
    '2': [ 2, 3, 6, 7, 10, 11, 14, 15, 18 ],
    '4': [ 4, 5, 6, 7, 12, 13, 14, 15, 20 ],
    '8': [ 8, 9, 10, 11, 12, 13, 14, 15, 24 ]
  }

  beforeEach -> @subject = new HammingCode([1, 0, 0, 1, 1, 0, 1, 0])

  describe 'basic attributes', ->
    expectThat -> (@subject.parity.bits).should.eql([1, 2, 4, 8])
    expectThat -> (@subject.positions.limit).should.eql(16)

  describe 'parity positions', ->
    expectThat ->
      (@subject.word).should.eql([null, null, 1, null, 0, 0, 1, null, 1, 0, 1, 0])

  describe 'check position calculation', ->
    expectThat -> (@subject.positions.checked).should.eql(positions_to_check)

  describe 'encode', ->
    beforeEach -> @subject.encode()
    expectThat -> (@subject.word).should.eql([0,1,1,1,0,0,1,0,1,0,1,0])

