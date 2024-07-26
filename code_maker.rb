require_relative 'role_factory'

class CodeMaker < RoleFactory
  CODE_LENGTH = 4
  RED_PEG = 0
  WHITE_PEG = 1
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

  def get_hint(code_pegs, key_pegs, turn)
    if turn >= 12
      return
    end
    code_pegs.each_with_index do |code_peg, i|
      self.move.each_with_index do |secret_peg, j|
        if (code_peg.representation == secret_peg.representation) && (i == j)
          self.hint.push(key_pegs[RED_PEG])
          break
        elsif code_peg.representation == secret_peg.representation
          self.hint.push(key_pegs[WHITE_PEG])
          break
        end
      end
    end
  end
end