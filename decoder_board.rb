# Board in which the mastermind game is played on
class DecoderBoard
  attr_accessor :code_peg_colors, :key_peg_colors, :code_peg_ansi, :key_peg_ansi

  def initialize
    self.code_peg_colors = %w[blue green yellow cyan magenta]
    self.key_peg_colors = %w[red white]
    self.code_peg_ansi = code_peg_colors.map { |color| to_ansi(color) }
    self.key_peg_ansi = key_peg_colors.map { |color| to_ansi(color) }
  end

  def display_board(game_state, code_breaker, code_maker, game_controller)
    if game_state.turn_count.zero?
      game_controller.init_guess(self, code_breaker)
    elsif game_state.turn_count >= 12 || game_state.code_broken?(code_maker.hint)
      print 'TURN %02d' % game_state.turn_count # rubocop:disable Style/FormatString
      print "| Your guess: #{code_breaker.move.map(&:representation).join(' ')} |
      Hint: #{code_maker.hint.map(&:representation).join(' ')} | "
      code_maker.hint.clear
    else
      print 'TURN %02d' % game_state.turn_count # rubocop:disable Style/FormatString
      print "| Your guess: #{code_breaker.move.map(&:representation).join(' ')} |
      Hint: #{code_maker.hint.map(&:representation).join(' ')} | "
      game_controller.init_guess(self, code_breaker)
      # reset code maker previous round's hints
      code_maker.hint.clear
    end
  end

  private

  def to_ansi(color) # rubocop:disable Metrics/CyclomaticComplexity
    case color # rubocop:disable Style/HashLikeCase
    when 'blue' then "\e[34m"
    when 'green' then "\e[32m"
    when 'yellow' then "\e[33m"
    when 'cyan' then "\e[36m"
    when 'magenta' then "\e[35m"
    when 'red' then "\e[31m"
    when 'white' then "\e[37m"
    end
  end
end
