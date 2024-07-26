class GameState
  attr_accessor :turn_count, :code_broken

  def initialize
    self.turn_count = 0
    self.code_broken = false
  end

  def game_over?(key_pegs)
    puts "#{key_pegs}"
    if key_pegs == []
      return false
    end
    self.code_broken = code_broken?(key_pegs)
    puts "code_broken: #{self.code_broken}"
    res = self.code_broken || self.turn_count > 12
    puts "#{res}"
    res
  end

  def code_broken?(key_pegs)
    red_ansi_code = "\e[31m"
    key_pegs.all? {|peg| peg.representation == "#{red_ansi_code}█\e[0m"} ? true : false
  end
end