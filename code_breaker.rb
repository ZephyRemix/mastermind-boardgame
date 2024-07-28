require_relative 'role_factory'
require_relative 'code_peg'

# The player with this role will be tasked to solve the mystery code
class CodeBreaker < RoleFactory
  def set_pegs(color_code, code_peg_ansi, _code_breaker)
    self.move = color_code.map { |code| CodePeg.new(code_peg_ansi[code]) }
  end
end
