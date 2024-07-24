require_relative 'peg'

class KeyPeg < Peg
  attr_accessor :count
  
  def initialize(color)
    self.count = 15
    super(color)
  end
end