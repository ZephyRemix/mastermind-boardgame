require_relative 'role_factory'

class CodeMaker < RoleFactory
  CODE_LENGTH = 4
  attr_accessor :hint, :score
  
  def initialize
    self.hint = []
    self.score = 0
    super
  end

  def make_code(peg_set)
    # randomly select  4 keys and get values
    colors = peg_set.values
    CODE_LENGTH.times {self.move.push(colors[rand(colors.length)])}
  end
end