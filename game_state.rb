class GameState
  attr_accessor :turn_count, :code_broken

  def initialize
    self.turn_count = 0
    self.code_broken = false
  end

  def game_over(key_pegs)
    red_ansi_code = "\e[31m"
    if key_pegs.all? {|peg| peg.representation == "#{red_ansi_code}█\e[0m"}
      self.code_broken = true
      return true
    elsif self.turn_count > 12
      return true
    else
      return false   
    end
  end
end