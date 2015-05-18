require_relative '../models/games_model'

class GamesController
  attr_accessor :player_name, :game_name, :game_description, :game_id

  def initialize
    @player_name = ''
    @game_name = ''
    @game_description = ''
  end

  def create
    puts "For starters, please enter your name.\n"
    @player_name = STDIN.gets.chomp
    sleep 1.2
    puts "Nice to meet you, #{@player_name}!\n"
    sleep 1.2
    puts "What's the name of your game?\n"
    @game_name = STDIN.gets.chomp
    sleep 1.2
    puts "#{@game_name} sounds like an awesome game!\n"
    sleep 1.2
    puts "Please add a description for Nashville Adventure. For example, you could say 'adventure-fantasy'.\n"
    @game_description = STDIN.gets.chomp
    sleep 1.2
    puts "Great! Please use the following menu options to further customize Nashville Adventure!\n"
    sleep 1.2
    add_new_game
    @game_id = get_game_id
  end

  def add_new_game
    GamesModel.add(@game_name,@player_name,@game_description)
  end

  def count
    GamesModel.count
  end

  def get_game_id
    GamesModel.get_id(@game_name)
  end
end
