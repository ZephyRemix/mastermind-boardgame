require_relative 'role_factory'
require_relative 'code_peg'
require_relative 'key_peg'

# The player with this role will be tasked to create the mystery code
class CodeMaker < RoleFactory
  CODE_LENGTH = 4
  RED = 0
  WHITE = 1
  attr_accessor :hint, :score

  def initialize
    self.hint = []
    self.score = 0
    super
  end

  def make_code(ansi_colors)
    # randomly select  4 keys and get values
    CODE_LENGTH.times { move.push(CodePeg.new(ansi_colors[rand(ansi_colors.length)])) }
  end

  def get_hint(code_pegs, key_peg_ansi, _turn)
    # if turn >= 12
    #   return
    # end

    secret_code_clone = find_position_match(code_pegs)
    find_color_match(code_pegs, secret_code_clone)
    get_key_pegs(code_pegs, key_peg_ansi)
  end

  private

  def find_position_match(code_pegs)
    secret_code_clone = move.map(&:clone)
    code_pegs.each_with_index do |code_peg, i|
      if code_peg.representation == secret_code_clone[i].representation
        code_pegs[i].match_pos = true
        secret_code_clone[i] = nil
      end
    end
    secret_code_clone
  end

  def find_color_match(code_pegs, secret_code_clone)
    code_pegs.each do |code_peg|
      secret_code_clone.each_with_index do |secret_peg, j|
        next unless !secret_peg.nil? && (code_peg.representation == secret_peg.representation)

        code_peg.match_color = true
        secret_code_clone[j] = nil
        break
      end
    end
  end

  def get_key_pegs(code_pegs, key_peg_ansi)
    # self.hint.clear
    code_pegs.each do |code_peg|
      if code_peg.match_pos
        hint << KeyPeg.new(key_peg_ansi[RED])
        next

      elsif code_peg.match_color
        hint << KeyPeg.new(key_peg_ansi[WHITE])
      end
    end
  end
end
