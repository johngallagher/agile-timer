class String
  def is_numerical?
    true if Float self rescue false
  end
end
