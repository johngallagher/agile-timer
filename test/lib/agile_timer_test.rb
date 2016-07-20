require 'minitest/autorun'
require_relative '../../lib/participant.rb'
require_relative '../../lib/agile_timer.rb'

class FakeParticipant
  def initialize(name:)
    @name = name
  end

  def name
    @name
  end

  def speak_name_out_loud!
  end
end

class AgileTimerTest < Minitest::Test
  def test_first_participant_is_driving_by_default
    ben = FakeParticipant.new(name: "Ben")
    john = FakeParticipant.new(name: "John")
    timer = agile_timer_with [ben, john]
    assert timer.is_participant_driving? ben
    refute timer.is_participant_driving? john
  end

  def test_when_time_is_up_second_participant_is_driving
    ben = FakeParticipant.new(name: "Ben")
    john = FakeParticipant.new(name: "John")
    timer = agile_timer_with [ben, john]
    assert timer.is_participant_driving? ben
    refute timer.is_participant_driving? john

    timer.wait_for_timer

    refute timer.is_participant_driving? ben
    assert timer.is_participant_driving? john
  end

  private

  def agile_timer_with participants
    AgileTimer.new(drive_time: 0, participants: participants)
  end
end
