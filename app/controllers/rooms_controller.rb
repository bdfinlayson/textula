#!/usr/bin/env ruby

require 'sqlite3'
require 'highline/import'
require_relative '../models/room'
require_relative '../models/exit'
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
    @rooms = Room.get_rooms(@game_id)
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
    Room.insert_follow_up(@game_id,@choice,@description,@description_prefix, @objects_list_prefix, @exits_prefix)
  end

  def add_choice_room
    Room.add_placeholder(@game_id, @choice)
  end


  def insert_choice_room_exit_into_database
    Exit.set_exit(@room, @choice,@opposite_direction)
  end

  def insert_exit_into_database
    Exit.set_exit(@choice, @room, @direction)
  end

  def add_room
    Room.create(@game_id, @room, @description,@description_prefix,@objects_list_prefix,@exits_prefix)
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
    Room.get_all_rooms_info(game_id)
  end

  def count(id)
    #if there are no rooms in the database it should return 0
    #if there are rooms it should return the correct count
    Room.get_rooms(id).size
  end

  def find_room_name(input, rooms)
    rooms.at(input - 1)
  end

  def find_room_by_name(room, game_id)
    Room.find_room_by_name(room, game_id)
  end

  def ask_for_which_room(id)
    Room.get_rooms(id)
  end

  def list_rooms(choices)
    choices.each_with_index { |choice, i| puts "#{i + 1}. #{choice}\n"}
    input = STDIN.gets.chomp.to_i
  end

  def change_room_name(room, game_id)
    input = STDIN.gets.chomp
    Room.edit_room_name(game_id, input, room)
  end


  def edit_loop(id)
    @game_id = id
    options = ['Edit Room Name', 'Edit Description', 'Edit Description Prefix', 'Edit Objects Prefix', 'Edit Exits Prefix']
    choices = ask_for_which_room(@game_id)
    input = list_rooms(choices)
    choice = find_room_name(input, choices)
    room = find_room_by_name(choice, @game_id)[0]
    puts "You selected: #{room}\n"
    puts "What change(s) would you like to make?\n\n"
    options.each_with_index { |option, i| puts "#{i + 1}. #{option}\n"}
    input = STDIN.gets.chomp.to_i
    case input
    when 1
      puts "The room is currently named: #{room}. What would you like to change the name to?\n"
      change_room_name(room, @game_id)
      puts "Your room has been updated!\n"
    when 2
      room_info = Room.get_all_room_info_by_name(room, @game_id)
      puts "Your room, #{room}, currently has the following description: #{room_info[0][3]}.\n"
      puts "What would you like to change the description to?\n"
      input = STDIN.gets.chomp
      Room.edit_room_description(room_info[0][0], input, room_info[0][3])
      puts "Your description has been updated!\n"
    end
  end
end
