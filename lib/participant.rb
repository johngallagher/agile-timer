class Participant
  def initialize(name:)
    @name = name
  end

  def name
    @name
  end

  def speak_name_out_loud!
    system("say 'Please can #{name} start driving'")
  end
end
