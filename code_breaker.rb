require_relative 'role_factory'
require_relative 'code_peg'

class CodeBreaker < RoleFactory
  def initialize
    super
  end

  def set_pegs(color_code, code_peg_ansi, code_breaker)
    self.move = color_code.map{|code| CodePeg.new(code_peg_ansi[code])}
  end

end