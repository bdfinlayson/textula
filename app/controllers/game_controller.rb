require_relative '../models/game_model'

class GameController
  attr_accessor :player_name, :game_name, :game_description

  def initialize
    @player_name = ''
    @game_name = ''
    @game_description = ''
  end

  def ask_for_name
    puts "Please state your name.\n"
  end

  def ask_for_game_name
    puts "Welcome to the game creator! What is the name of your game?\n"
  end

  def ask_for_game_description
    puts "Please add a description for your game.\n"
  end

  def create
    ask_for_game_name
    @game_name = STDIN.gets.chomp
    sleep 1.2
    ask_for_name
    @player_name = STDIN.gets.chomp
    sleep 1.2
    ask_for_game_description
    @game_description = STDIN.gets.chomp
    sleep 1.2
  end

  def add_new_game
    GameModel.add(@game_name,@player_name,@game_description)
  end

  def count
    GameModel.count
  end
end
