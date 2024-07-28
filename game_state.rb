# This class is used to state of game, including both turn counter, and win conditions
class GameState
  attr_accessor :turn_count, :code_broken

  def initialize
    self.turn_count = 0
    self.code_broken = false
  end

  def game_over?(key_pegs)
    return false if turn_count < 12 && key_pegs == []

    self.code_broken = code_broken?(key_pegs)
    # puts "code_broken: #{self.code_broken}"
    code_broken || turn_count >= 12
    # puts "#{res}"
  end

  def code_broken?(key_pegs)
    red_ansi_code = "\e[31m"

    # Condition 1: have 4 key pegs
    return false if key_pegs.length != 4

    # Condition 2: Get to the end of 4 key pegs without without entering the guard against white pegs
    key_pegs.each do |key_peg| # rubocop:disable Lint/UnreachableLoop
      return false if key_peg.representation != "#{red_ansi_code}█\e[0m"

      return true
    end
  end

  def calculate_score
    if code_broken
      puts "\nCodemaker got the better of the mystery, only needing #{turn_count} rounds!".colorize(:green)
      score = turn_count == 12 ? turn_count + 1 : turn_count
    else
      puts "\nCodebreaker failed to solve the mystery!".colorize(:red)
      score = turn_count + 1
    end
    score
  end
end
