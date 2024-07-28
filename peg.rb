# Parent class for Code Peg and Key Peg
class Peg
  attr_accessor :color, :symbol, :representation

  def initialize(color)
    self.color = color
    self.symbol = '█'
    self.representation = colorize(symbol, color)
  end

  private

  def colorize(symbol, color)
    reset = "\e[0m"
    "#{color}#{symbol}#{reset}"
  end
end
