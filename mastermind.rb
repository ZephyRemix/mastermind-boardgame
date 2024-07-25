require 'colorize'
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
board.generate_pegs

# game starts
puts "Round starts! Computer is cookin'"
computer.make_code(board.code_peg_set)
# computer.move.each {|peg| puts peg.representation}

game_controller.show_instructions(board.code_peg_colors)

game_state = GameState.new

until game_state.game_over?(computer.hint)
  puts "entered loop"
  board.display_board(game_state, human, computer, game_controller)
  puts "printed board"
  game_state.turn_count += 1
  computer.get_hint(human.move, board, key_peg_set)
end