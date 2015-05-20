#!/usr/bin/env ruby

require 'sqlite3'
require 'highline/import'
require_relative '../models/rooms_model'
require_relative '../models/exits_model'
require_relative '../../lib/database'
require_relative 'games_controller'

class RoomsController

  attr_accessor :room, :description, :rooms, :choice, :game_id

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
    @opposite_direction = ''
    @game_id = ''
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
    puts "You created a description for the #{@room}. It reads: #{@description}.\n"
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

  def start(game_id)
    @game_id = game_id
    #Database.load_structure
    run_program
  end

  def run_program
    @rooms = RoomsModel.get_rooms(@game_id)
    if @rooms.empty?
      puts "Your game currently has no rooms.\n"
    else
      list_current_rooms
    end
    ask_for_room
    @room = STDIN.gets.chomp
    splash_new_room
    ask_for_description
    @description = STDIN.gets.chomp
    splash_new_description
    if @rooms.empty?
      puts "What rooms does the #{@room} lead to? You currently have no rooms to choose from, but you can go ahead and declare a room now!\n"
      @choice = STDIN.gets.chomp
      puts "Great! The #{@room} has an exit to the #{@choice}! In a moment we will ask you for more information about the room called #{@choice}!\n"
      ask_for_direction
      @direction = STDIN.gets.chomp
      puts "And the opposite direction of #{@direction} is what?\n"
      @opposite_direction = STDIN.gets.chomp
      puts "Awesome! The #{@room} has a #{@direction} exit that leads to the #{@choice}!\n"
      puts "The #{@choice} also has a #{@opposite_direction} exit that leads to the #{@room}!\n"
    else
      ask_for_exit
      @choice = STDIN.gets.chomp
      confirm_choice_in_database
      ask_for_direction
      @direction = STDIN.gets.chomp
      puts "And the opposite direction of #{@direction} is what?\n"
      @opposite_direction = STDIN.gets.chomp
      splash_exit_direction_confirmation
      puts "The #{@choice} also has a #{@opposite_direction} exit that leads to the #{@room}!\n"
    end
    ask_for_description_prefix
    @description_prefix = STDIN.gets.chomp
    splash_description_prefix_confirmation
    ask_for_objects_list_prefix
    @objects_list_prefix = STDIN.gets.chomp
    splash_objects_list_prefix_confirmation
    ask_for_exits_prefix
    @exits_prefix = STDIN.gets.chomp
    splash_exits_prefix_confirmation
    if @rooms.empty?
      add_choice_room
      add_room
      insert_choice_room_exit_into_database
      insert_exit_into_database
      ask_follow_up_questions
    else
      add_room
      insert_exit_into_database
      insert_choice_room_exit_into_database
      puts "To add another room, please choose 'Add room' from the main menu. To play the game, please choose 'Play game'.\n"
    end
  end

  def ask_follow_up_questions
    puts "Earlier you created a room called #{@choice} that did not exist previously. Please add more information about this room.\n"
    puts "What is the description of your #{@choice}?\n"
    @description = STDIN.gets.chomp
    puts "You created a description for #{@choice}. It reads: #{@description}.\n"
    puts "The #{@choice} already has a #{@opposite_direction} exit that leads to the #{@room}.\n"
    ask_for_description_prefix
    @description_prefix = STDIN.gets.chomp
    puts "Excellent! Your description prefix will read like this: #{@description_prefix} #{@choice}.\n"
    ask_for_objects_list_prefix
    @objects_list_prefix = STDIN.gets.chomp
    splash_objects_list_prefix_confirmation
    ask_for_exits_prefix
    @exits_prefix = STDIN.gets.chomp
    puts "Marvelous! Your exit prefix will read like this: #{@exits_prefix} #{@opposite_direction}.\n"
    puts "To add another room, please choose 'Add room' from the main menu. To play the game, please choose 'Play game'.\n"
    insert_follow_up
  end

  def insert_follow_up
    RoomsModel.insert_follow_up(@game_id,@choice,@description,@description_prefix, @objects_list_prefix, @exits_prefix)
  end

  def add_choice_room
    RoomsModel.add_placeholder(@game_id, @choice)
  end


  def insert_choice_room_exit_into_database
    ExitsModel.set_exit(@room, @choice,@opposite_direction)
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

  def all(game_id)
    RoomsModel.get_all_rooms_info(game_id)
  end

  def count(id)
    #if there are no rooms in the database it should return 0
    #if there are rooms it should return the correct count
    RoomsModel.get_rooms(id).size
  end

end
