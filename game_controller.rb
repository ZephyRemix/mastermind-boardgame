require_relative 'code_breaker'
require_relative 'code_maker'

class GameController
  attr_accessor :players
  
  def initialize
    self.players = []
  end

  def init_player_role(factory)
    human = factory.create_role(:break)
    computer = factory.create_role(:make)
    players << human
    players << computer
  end

  def show_instructions(code_peg_colors)
    # self.code_peg_colors = ["blue", "green", "yellow", "cyan", "magenta"]
    code_peg_colors.each_with_index {|color_str, idx| print "- #{(idx.to_s).colorize(color_str.to_sym)} -"}
    puts "\nPlease enter 4 digits corresponding to the colors above: e.g. 0243"
  end

  def init_guess(board, code_breaker)
    print "Enter new guess: "
    color_codes = gets.chomp.split("").map{|num| num.to_i}
    set_pegs(color_codes, board, code_breaker)
  end

  private

  def set_pegs(color_code, board, code_breaker)
    chosen_pegs = color_code.map{|code| board.code_peg_set[code]}
    code_breaker.move = chosen_pegs
  end
end