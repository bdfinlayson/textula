#!/usr/bin/env ruby

require 'sqlite3'
require 'highline/import'
require_relative '../controllers/rooms_controller'
require_relative '../models/rooms_model'
require_relative '../models/exits_model'
require_relative '../../lib/rooms_database'
require_relative '../../lib/exits_database'

class RoomsController

  attr_accessor :room, :description, :rooms, :choice

  def initialize
    RoomsDatabase.load_structure
    @room = ''
    @description = ''
    @rooms = []
    @choice = ''
    @direction = ''
  end

  def ask_for_room
    puts "What is the name of the room you want to add.\n"
  end

  def splash_new_room
    puts "You created a #{@room}.\n"
  end

  def ask_for_description
    puts "What is the description of your #{@room}.\n"
  end

  def splash_new_description
    puts "You created a description for #{@room}. It reads: #{@description}.\n"
  end

  def ask_for_exit
    puts "What rooms does the #{@room} lead to? You can choose from: #{@rooms.join(', ')}.\n"
  end

  def splash_exit_confirmation
    puts "Great! The #{@room} has an exit to the #{@choice}!\n"
  end

  def splash_wrong
    puts "Sorry, #{@choice} is not something I recognize.\n"
  end

  def ask_for_direction
    puts "The exit from the #{@room} to the #{@choice} is in which direction? (e.g., 'north', 'south', 'east', 'west')\n"
  end

  def splash_exit_direction_confirmation
    puts "Awesome! The #{@room} has a #{@direction} exit that leads to the #{@choice}!\n"
  end

  def start
    RoomsDatabase.load_structure
    if RoomsModel.is_start_of_game? > 0
      # maybe do something??
    else
      # create default room
      RoomsModel.create_default_starting_room
    end
    run_program
    give_confirmation
    RoomsModel.update_database(@room, @description)
  end

  def run_program
    sleep 1.2
    ask_for_room
    @room = STDIN.gets.chomp
    sleep 1.2
    splash_new_room
    sleep 1.2
    ask_for_description
    @description = STDIN.gets.chomp
    splash_new_description
    sleep 1.2
    @rooms = RoomsModel.get_rooms
    ask_for_exit
    @choice = STDIN.gets.chomp
    confirm_choice_in_database_and_insert
    ask_for_direction
    @direction = STDIN.gets.chomp
    insert_exit_into_database
    splash_exit_direction_confirmation
  end

  def insert_exit_into_database
    ExitsModel.set_exit(@choice, @room, @direction)
  end

  def confirm_choice_in_database_and_insert
    if @rooms.include?(@choice)
      RoomsModel.insert_into_database(@room, @description)
      splash_exit_confirmation
    else
      splash_wrong
    end
  end

  def index
    if count > 0
      rooms = Rooms.all # all the rooms in the array
      rooms.each_with_index do |room, index|
        say("#{index + 1}. #{room.name}")
      end
    else
      say("No rooms found. Add a room.\n")
    end
  end

  def all
    RoomsModel.get_all_rooms_info
  end

  def count
    #if there are no rooms in the database it should return 0
    #if there are rooms it should return the correct count
    RoomsModel.get_rooms.size
  end

end
