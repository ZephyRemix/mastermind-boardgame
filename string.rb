# String class extension to enable validation of input string to be a numeric string
class String
  def numeric?
    !Integer(self).nil?
  rescue StandardError
    false
  end
end
