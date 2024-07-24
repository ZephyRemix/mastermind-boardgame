require_relative 'peg'

class CodePeg < Peg
  attr_accessor :count

  def initialize(color)
    self.count = 12
    super(color)
  end
end