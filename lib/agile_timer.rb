class AgileTimer
  def initialize params
    @drive_time = drive_time_in_seconds(params[:drive_time])
    @participants = params[:participants]
    @current_driver_index = 0
    current_driver.speak_name_out_loud!
  end

  def is_participant_driving? participant
    current_driver == participant
  end

  def wait_for_timer
    sleep @drive_time
    move_to_next_driver!
    current_driver.speak_name_out_loud!
  end

  private

  def drive_time_in_seconds drive_time
    (drive_time.to_i) * 60
  end

  def participant_is_first? participant
    @participants.index(participant) == 0
  end

  def number_of_participants
    @participants.length
  end

  def reached_end_of_participants?
    @current_driver_index == number_of_participants - 1
  end

  def current_driver
    @participants[@current_driver_index]
  end

  def move_to_next_driver!
    if reached_end_of_participants?
      @current_driver_index = 0
    else
      @current_driver_index += 1
    end
  end
end

