class DecoderBoard
  attr_accessor :code_peg_colors, :key_peg_colors, :code_peg_ansi, :key_peg_ansi

  def initialize
    self.code_peg_colors = ["blue", "green", "yellow", "cyan", "magenta"]
    self.key_peg_colors = ["red", "white"]
    self.code_peg_ansi = self.code_peg_colors.map {|color| self.to_ansi(color)}
    self.key_peg_ansi = self.key_peg_colors.map {|color| self.to_ansi(color)}
  end

  def display_board(game_state, code_breaker, code_maker, game_controller)
    # binding.pry
    if game_state.turn_count == 0
      game_controller.init_guess(self, code_breaker)
    elsif game_state.turn_count == 12 || game_state.code_broken?(code_maker.hint)
      print "TURN %02d" % game_state.turn_count 
      print "| Your guess: #{code_breaker.move.map{|peg| peg.representation}.join(' ')} | Hint: #{code_maker.hint.map{|peg| peg.representation}.join(' ')} | "
      # print "TURN #{game_state.turn_count} | Your guess: #{code_breaker.move.map{|peg| peg.representation}.join(' ')} | Hint: #{code_maker.hint.map{|peg| peg.representation}.join(' ')} | "
      code_maker.hint.clear
    else 
      print "TURN %02d" % game_state.turn_count 
      print "| Your guess: #{code_breaker.move.map{|peg| peg.representation}.join(' ')} | Hint: #{code_maker.hint.map{|peg| peg.representation}.join(' ')} | "
      # print "TURN #{game_state.turn_count} | Your guess: #{code_breaker.move.map{|peg| peg.representation}.join(' ')} | Hint: #{code_maker.hint.map{|peg| peg.representation}.join(' ')} | "
      game_controller.init_guess(self, code_breaker)
      # reset code maker previous round's hints
      code_maker.hint.clear
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
    when "red"; "\e[31m"
    when "white"; "\e[37m"
    end
  end
end 