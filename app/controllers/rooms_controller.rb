#!/usr/bin/env ruby

require 'sqlite3'
require 'highline/import'
require_relative '../models/rooms_model'
require_relative '../models/exits_model'
require_relative '../../lib/database'

class RoomsController

  attr_accessor :room, :description, :rooms, :choice

  def initialize
    Database.load_structure
    @room = ''
    @description = ''
    @rooms = []
    @choice = ''
    @direction = ''
    @description_prefix = ''
    @objects_list_prefix = ''
    @exits_prefix = ''
  end

  def list_current_rooms
    puts "Your game currently has the following rooms: #{@rooms.join(', ')}.\n"
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

  def ask_for_description_prefix
    puts "Please enter a description prefix for your room. (e.g. 'You are in the', 'You are in a', 'You are on the')\n"
  end

  def splash_description_prefix_confirmation
    puts "Excellent! Your description prefix will read like this: #{@description_prefix} #{@room}."
  end

  def ask_for_objects_list_prefix
    puts "Please enter an objects list prefix for the objects in your room. (e.g., 'You can see')\n"
  end

  def splash_objects_list_prefix_confirmation
    puts "Fantastic! Your objects list prefix is: #{@objects_list_prefix}.\n"
  end

  def ask_for_exits_prefix
    puts "Please enter an exits prefix for the exits in your room. (e.g., 'You can go')\n"
  end

  def splash_exits_prefix_confirmation
    puts "Marvelous! Your exit prefix will read like this: #{@exits_prefix} #{@direction}.\n"
  end

  def start
    Database.load_structure
    if RoomsModel.is_start_of_game? > 0
      # maybe do something??
    else
      # create default room
      RoomsModel.create_default_starting_room
    end
    run_program
  end

  def run_program
    sleep 1.2
    @rooms = RoomsModel.get_rooms
    list_current_rooms
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
    ask_for_exit
    @choice = STDIN.gets.chomp
    confirm_choice_in_database
    sleep 1.2
    ask_for_direction
    @direction = STDIN.gets.chomp
    insert_exit_into_database
    sleep 1.2
    splash_exit_direction_confirmation
    sleep 1.2
    ask_for_description_prefix
    @description_prefix = STDIN.gets.chomp
    sleep 1.2
    splash_description_prefix_confirmation
    sleep 1.2
    ask_for_objects_list_prefix
    @objects_list_prefix = STDIN.gets.chomp
    sleep 1.2
    splash_objects_list_prefix_confirmation
    sleep 1.2
    ask_for_exits_prefix
    @exits_prefix = STDIN.gets.chomp
    sleep 1.2
    splash_exits_prefix_confirmation
    sleep 1.2
    puts "To add another room, please choose 'Add room' from the main menu. To play the game, please choose 'Play game'.\n"
    add_room
  end

  def insert_exit_into_database
    ExitsModel.set_exit(@choice, @room, @direction)
  end

  def add_room
    RoomsModel.create(@game_id, @room, @description,@description_prefix,@objects_list_prefix,@exits_prefix)
  end

  def confirm_choice_in_database
    if @rooms.include?(@choice)
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
