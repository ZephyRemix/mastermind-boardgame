class GameState
  attr_accessor :turn_count, :code_broken

  def initialize
    self.turn_count = 0
    self.code_broken = false
  end

  def game_over?(key_pegs)
    if turn_count < 12 && key_pegs == []
      return false
    end
    self.code_broken = code_broken?(key_pegs)
    # puts "code_broken: #{self.code_broken}"
    res = self.code_broken || self.turn_count > 12
    # puts "#{res}"
    res
  end

  def code_broken?(key_pegs)
    red_ansi_code = "\e[31m"

    # Condition 1: have 4 key pegs 
    return false if key_pegs.length != 4
    # Condition 2: Get to the end of 4 key pegs without without entering the guard against white pegs
    key_pegs.each do |key_peg|
      if key_peg.representation != "#{red_ansi_code}█\e[0m"
        return false 
      end
      return true
    end
  end

  def calculate_score
    if self.code_broken
      self.turn_count == 12 ? score = turn_count + 1 : score = turn_count
    else
      score = turn_count 
    end
  end
end