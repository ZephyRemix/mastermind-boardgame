class RoleFactory
  attr_accessor :move
  
  def initialize
    self.move = []
  end

  def create_role(role)
    case role
    when :break
      CodeBreaker.new
    when :make
      CodeMaker.new
    else 
      raise "Unknown role: #{role}"
    end
  end
end