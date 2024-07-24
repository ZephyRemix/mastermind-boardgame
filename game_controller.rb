require_relative 'code_breaker'
require_relative 'code_maker'

class GameController
  attr_accessor :players
  
  def initialize
    self.players = []
  end

  def init_player_role(factory)
    human = factory.create_role(:break)
    computer = factory.create_role(:make)
    players << human
    players << computer
  end
end