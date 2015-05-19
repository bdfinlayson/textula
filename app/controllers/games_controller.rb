require_relative '../models/games_model'

class GamesController
  attr_accessor :player_name, :game_name, :game_description, :game_id
  DEFAULT_START_LOCATION = "living room"

  def initialize
    @player_name = ''
    @game_name = ''
    @game_id = ''
    @game_description = ''
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
    @game_id = get_game_id
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
    PlayersController.new(@game_id, DEFAULT_START_LOCATION, @player_name)
    puts "Loading #{@game_name}...\n"
    game_loop
  end

  def game_loop


  end
end
