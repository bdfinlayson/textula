require_relative '../models/game'
require_relative '../models/room'
require_relative '../models/exit'

class GamesController
  attr_accessor :player_name, :game_name, :game_description, :game_id, :player

  def initialize
    @player_name = ''
    @game_name = ''
    @game_id = ''
    @game_description = ''
    @start_location = ''
    @player = ''
  end

  def create
    puts "For starters, please enter your name.\n"
    @player_name = STDIN.gets.chomp
    puts "Nice to meet you, #{@player_name}!\n"
    puts "What's the name of your game?\n"
    @game_name = STDIN.gets.chomp
    puts "#{@game_name} sounds like an awesome game!\n"
    puts "Please add a description for #{@game_name}. For example, you could say 'adventure-fantasy'.\n"
    @game_description = STDIN.gets.chomp
    puts "Great! Please use the following menu options to further customize #{@game_name}!\n"
    add_new_game
    @game_id = get_game_id[0][0]
  end

  def add_new_game
    Game.create(@game_name,@player_name,@game_description)
  end

  def count
    Game.count
  end

  def get_game_id
    Game.get_id(@game_name)
  end

  def play
    @start_location = get_start_location
    @player = PlayersController.new(@game_id, @start_location, @player_name)
    @player.create
    puts "Loading #{@game_name}...\n"
    game_loop
  end

  def get_start_location
    location = Room.get_start_location(@game_id)
    location[1][0]
  end

  def game_loop
    loop do
      room_prefix = get_room_prefix
      room = get_room
      puts "#{room_prefix} #{room}.\n"
      directions_prefix = get_directions_prefix
      directions = get_directions
      puts "#{directions_prefix} #{directions}.\n"
      description = get_description
      puts "The #{room} is #{description}.\n"
      input = STDIN.gets.chomp
      if input == "quit"
        puts "Thanks for playing!\n"
        return
      else
        #interpret the input
        #break the input into an array
        input_array = input.split(' ')
        #break the directions into an array
        directions_array = directions.split(', ')
        #determine which direction they want to go
        direction = input_array.find { |d| directions_array.include?(d) }
        if direction
          #then find the room that corresponds with that direction
          #and get the id of that room
          new_location_id = find_new_location_id(direction)
          #update the player location with that id
          @player.location = new_location_id
          #go to next room
        else
          puts "invalid direction!"
        end
      end
    end
  end

  def find_new_location_id(direction)
    id = Exit.get_new_location_id(direction, @player.location)
    id[0][0]
  end

  def get_room_prefix
    prefix = Room.get_room_prefix(@player.location)
    prefix[0][0]
  end

  def get_room
    room = Room.get_room(@player.location)
    room[0][0]
  end

  def get_directions_prefix
    prefix = Room.get_directions_prefix(@player.location)
    prefix[0][0]
  end

  def get_directions
    directions = Exit.get_directions(@player.location)
    directions.flatten.join(', ')
  end

  def get_description
    description = Room.get_description(@player.location)
    description[0][0]
  end

  def get_all_games
    Game.get_all_games
  end

  def find_game(name)
    Game.find_game(name)
  end

  def find_game_name(input, games)
    games.at(input - 1)
  end

  def ask_for_which_game
    games = get_all_games
    games.each_with_index { |game, i| puts "#{i + 1}. #{game[0]}\n"}
    input = STDIN.gets.chomp.to_i
    name = find_game_name(input,games)
    game_info = find_game(name)
    set_game_stats(game_info)
  end

  def set_game_stats(game_info)
    @player_name = game_info[0][2]
    @game_name = game_info[0][1]
    @game_id = game_info[0][0]
    @game_description = game_info[0][3]
    @start_location = get_start_location
    @player = PlayersController.new(@game_id, @start_location, @player_name)
    @player.create
  end
end
