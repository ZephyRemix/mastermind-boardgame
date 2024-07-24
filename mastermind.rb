require_relative 'game_controller'
require_relative 'role_factory'
require_relative 'decoder_board'

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