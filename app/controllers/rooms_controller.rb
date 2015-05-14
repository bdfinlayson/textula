#!/usr/bin/env ruby

require 'sqlite3'
require 'highline/import'
require_relative '../controllers/rooms_controller'
require_relative '../models/rooms_model'
require_relative '../../lib/rooms_database'

class RoomsController

  attr_accessor :room, :description, :rooms, :choice

  def initialize
    RoomsDatabase.load_structure
    @room = ''
    @description = ''
    @rooms = []
    @choice = ''
    @next_to = ''
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

  def ask_for_next
    puts "What is the #{@room} next to? You can choose from: #{@rooms.join(', ')}.\n"
  end

  def splash_confirmation
    puts "Great! The #{@room} is next to the #{@choice}!\n"
  end

  def splash_wrong
    puts "Sorry, #{@choice} is not something I recognize.\n"
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
    RoomsModel.update_database(@room, @description, @next_to)
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
    ask_for_next
    @choice = STDIN.gets.chomp
  end

  def give_confirmation
    if @rooms.include?(@choice)
      RoomsModel.get_relation(@choice, @room)
      splash_confirmation
      @next_to = @choice
    else
      splash_wrong
    end
  end

  def index
    if Rooms.count > 0
      rooms = Rooms.all # all the rooms in the array
      rooms.each_with_index do |room, index|
        say("#{index + 1}. #{room.name}")
      end
    else
      say("No rooms found. Add a room.\n")
    end
  end
end
