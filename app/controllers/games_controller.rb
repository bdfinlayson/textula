require_relative '../models/games_model'
require_relative '../models/rooms_model'

class GamesController
  attr_accessor :player_name, :game_name, :game_description, :game_id

  def initialize
    @player_name = ''
    @game_name = ''
    @game_id = ''
    @game_description = ''
    @start_location = ''
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
    GamesModel.create(@game_name,@player_name,@game_description)
  end

  def count
    GamesModel.count
  end

  def get_game_id
    GamesModel.get_id(@game_name)
  end

  def play
    @start_location = get_start_location
    player = PlayersController.new(@game_id, @start_location, @player_name)
    player.create
    puts "Loading #{@game_name}...\n"
  end

  def get_start_location
    location = RoomsModel.get_start_location(@game_id)
    location[0][0]
  end

  def game_loop

  end
end
