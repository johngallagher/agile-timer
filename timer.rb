#!/usr/bin/env ruby
Dir.glob('lib/**/*.rb') { |f| require_relative f }

class Program
  def initialize
    clear_display
    @participants = get_participants
    @drive_time = get_drive_time
    @timer = AgileTimer.new({ drive_time: @drive_time, participants: @participants })
    begin_timing
  end

  private

  def begin_timing
    while true
      clear_display
      output_participants
      @timer.wait_for_timer
    end
  end

  def get_drive_time
    puts "Please enter minutes each person should drive for"
    while true
      drive_time = gets.chomp
      if drive_time.is_numerical?
        clear_display
        return drive_time
      else
        puts "Not a valid number. Please try again."
      end
    end
  end

  def get_participants
    puts "Please enter driver names. Enter blank when finished"
    participants = []
    while true
      participant_name = gets.chomp
      if participant_name.empty?
        clear_display
        return participants
      else
        participants << Participant.new(name: participant_name)
      end
    end
  end

  def output_participants
    puts "=================="
    puts " Timer is running "
    puts "=================="
    @participants.each do |participant|
      if @timer.is_participant_driving?(participant)
        puts "> #{participant.name}"
      else
        puts " #{participant.name}"
      end
    end
  end

  def clear_display
    system("clear")
  end
end

Program.new
