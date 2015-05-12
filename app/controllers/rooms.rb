#!/usr/bin/env ruby

require 'sqlite3'
require 'highline/import'

class Rooms

  attr_accessor :room, :description, :rooms, :choice

  def initialize
    @room = ''
    @description = ''
    @rooms = []
    @choice = ''
    @db = SQLite3::Database.new( make_directory  )
    @next_to = ''
  end

  def make_directory
    directory = "data"
    Dir.mkdir(directory) unless File.exist?(directory)
    dbname = "#{directory}/rooms.sqlite"
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
    run_program
    give_confirmation
    update_database
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
    make_database
    get_rooms
    ask_for_next
    @choice = STDIN.gets.chomp
  end

  def make_database
    @db.execute("drop table if exists rooms")
    @db.execute("create table rooms(id integer primary key autoincrement, room text, description text, next_to integer)")
    @db.execute("insert into rooms(room, description) values ('living room', 'A quiet place to read. You see a fireplace in one corner.')")
  end

  def get_rooms
    @rooms = @db.execute("select room from rooms").flatten
  end

  def give_confirmation
    if @rooms.include?(@choice)
      relation = @db.execute("select room from rooms where room like ?", "#{@choice}").flatten
      @db.execute("update rooms set next_to = '#{relation[relation.index(@choice)]}' where room = '#{@room}'")
      splash_confirmation
      @next_to = @choice
    else
      splash_wrong
    end
  end

  def update_database
    @db.execute("insert into rooms (room, description, next_to) values ('#{@room}','#{@description}','#{@next_to}')")
  end

end
