require_relative 'code_peg'
require_relative 'key_peg'

class DecoderBoard
  attr_accessor :code_peg_set, :key_peg_set, :code_peg_colors, :key_peg_colors

  def initialize
    self.code_peg_set = Hash.new
    self.key_peg_set = Hash.new
    self.code_peg_colors = ["blue", "green", "yellow", "cyan", "magenta"]
    self.key_peg_colors = ["red", "white"]
  end

  def generate_pegs
    code_peg_ansi = code_peg_colors.map {|color| to_ansi(color)}
    key_peg_ansi = key_peg_colors.map {|color| to_ansi(color)}

    #generate code and key pegs
    generate_peg_set(code_peg_ansi, code_peg_set, true)
    generate_peg_set(key_peg_ansi, key_peg_set, false)
  end

  def display_board(game_state, code_breaker, code_maker, game_controller)
    if game_state.turn_count == 0
      game_controller.init_guess(self, code_breaker)
    elsif game_state.turn_count == 12 || game_state.code_broken?(code_maker.hint)
      print "TURN #{game_state.turn} | Your guess: #{code_breaker.move.map{|peg| peg.representation}.join('')} | 
      Hint: #{code_maker.move.map{|peg| peg.representation}.join('')}"
    else 
      print "TURN #{game_state.turn} | Your guess: #{code_breaker.move.map{|peg| peg.representation}.join('')} | 
      Hint: #{code_maker.move.map{|peg| peg.representation}.join('')}"
      game_controller.init_guess(self, code_breaker)
    end
  end
  private

  def to_ansi(color)
    case color
    when "blue"; "\e[34m"
    when "green"; "\e[32m"
    when "yellow"; "\e[33m"
    when "cyan"; "\e[36m"
    when "magenta"; "\e[35m"
    end
  end

  def generate_peg_set(ansi_color_str_array, peg_set_hash, is_code_peg)
    if is_code_peg ? 
      ansi_color_str_array.each_with_index {|color, idx| peg_set_hash[idx] = CodePeg.new(color)} : 
      ansi_color_str_array.each_with_index {|color, idx| peg_set_hash[idx] = KeyPeg.new(color)}
    end
  end
end