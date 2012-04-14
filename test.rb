
class HammingCode
  attr_accessor :word, :input, :parity_bits, :check_positions

  def initialize(input = nil)
    self.word = input
    self.input = input
    self.parity_bits = progression(4,2)
    self.check_positions = {}
    insert_parity_positions
    calculate_check_positions
  end
  
  def encode
    check_positions.each do |bit,positions|
      parity = positions.map { |position| word[position - 1] }
      p "Bit - #{bit}. Positions - #{positions}. Parity #{parity.compact}."
      word[bit - 1] = parity.count(1).even?? 0 : 1
    end
    p word.inspect
  end

  private

  def progression(times, rank, start = 1)
    (0...times).map { |el| start * rank ** el }
  end

  def insert_parity_positions
   parity_bits.each do | position |
     word.insert(position - 1, nil)
   end
  end

  def calculate_check_positions
    parity_bits.each do | bit |
      check_positions[bit] = positions(Array(bit),bit)
    end
  end

  def positions(container, bit)
   limit = progression(5,2)[-1] * 2
   puts limit
   while container[-1] < limit do
     last = container[-1].to_i
     last += step(container,bit)
     container << last
   end
   container
  end
 
  def step(container, bit)
    (container.length % bit == 0) ? (bit + 1) : 1
  end 
end

word = [1,0,0,1,1,0,1,0 ]
#p word.inspect

code = HammingCode.new( word )
code.encode



