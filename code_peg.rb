require_relative 'peg'

# Code pegs are used by code maker to create mystery code; code breaker to crack the mystery code
class CodePeg < Peg
  attr_accessor :count, :match_pos, :match_color

  def initialize(color)
    self.match_pos = false
    self.match_color = false
    super
  end
end
