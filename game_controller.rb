require_relative 'code_breaker'
require_relative 'code_maker'
require_relative 'string'

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

  # def init_guess(board, code_breaker)
  #   print "Enter new guess: "
  #   color_codes = gets.chomp.split("").map{|num| num.to_i}
  #   code_breaker.set_pegs(color_codes, board.code_peg_ansi, code_breaker)
  # end

  def init_guess(board, code_breaker)
    while true
      print "Enter new guess: "
      user_input = gets.chomp
      if (user_input.length == 4 && user_input.numeric? && valid_range?(user_input))
        color_codes = user_input.split("").map{|num| num.to_i}
        code_breaker.set_pegs(color_codes, board.code_peg_ansi, code_breaker)
        break
      end
    end 
  end
  
  def announce_points(score)
    puts "Code maker scored #{score} points!".colorize(:green)
  end

  private

  def valid_range?(str)
    str =~ /\A[01234]+\z/ ? true : false
  end
end