require_relative 'peg'

class CodePeg < Peg
  attr_accessor :count, :match_pos, :match_color

  def initialize(color)
    self.count = 12
    self.match_pos = false
    self.match_color = false
    super(color)
  end
end