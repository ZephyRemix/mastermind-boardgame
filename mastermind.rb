require 'colorize'
require 'pry-byebug'
require_relative 'game_controller'
require_relative 'role_factory'
require_relative 'decoder_board'
require_relative 'game_state'

game_controller = GameController.new
role_factory = RoleFactory.new
game_controller.init_player_role(role_factory)
human = game_controller.players[0]; computer = game_controller.players[1]

# create board
board = DecoderBoard.new

# game starts
puts "Round starts! Computer is cookin'"
computer.make_code(board.code_peg_ansi)
puts "Code maker   move: #{computer.move.map {|peg| peg.representation}.join(' ')}}}"
game_controller.show_instructions(board.code_peg_colors)

game_state = GameState.new

until game_state.game_over?(computer.hint)
  board.display_board(game_state, human, computer, game_controller)
  game_state.turn_count += 1
  computer.get_hint(human.move, board.key_peg_ansi, game_state.turn_count)
end

# display game winning hand
if game_state.game_over?(computer.hint)
  board.display_board(game_state, human, computer, game_controller)
  computer.get_hint(human.move, board.key_peg_ansi, game_state.turn_count)
end

# announce score 
game_controller.announce_points(game_state.calculate_score)