require_relative '../test_helper'
require 'sqlite3'

class PlayingGameTest < Minitest::Test

  def test_integration_0a_playing_a_simple_game
    shell_output = ''
    expected_output = ''
    IO.popen(' ./textula start', 'r+') do |pipe|
      expected_output = start_menu
      pipe.puts "1"
      expected_output << "Welcome to Textula! The Textula game engine will now walk you through creating your own text-adventure game! So lets get started!\n"
      expected_output << "For starters, please enter your name.\n"
      pipe.puts "Bryan"
      expected_output << "Nice to meet you, Bryan!\n"
      expected_output << "What's the name of your game?\n"
      pipe.puts "Nashville Adventure"
      expected_output << "Nashville Adventure sounds like an awesome game!\n"
      expected_output << "Please add a description for Nashville Adventure. For example, you could say 'adventure-fantasy'.\n"
      pipe.puts "adventure-fantasy"
      expected_output << "Great! Please use the following menu options to further customize Nashville Adventure!\n"
      expected_output << main_menu
      pipe.puts "1"
      expected_output << "Welcome to the room creator!\n"
      expected_output << "Your game currently has the following rooms: living room.\n"
      expected_output << "What is the name of the room you want to add.\n"
      pipe.puts "kitchen"
      expected_output << "You created a kitchen.\n"
      expected_output << "What is the description of your kitchen.\n"
      pipe.puts "It is barely large enough for two people"
      expected_output << "You created a description for kitchen. It reads: It is barely large enough for two people.\n"
      expected_output << "What rooms does the kitchen lead to? You can choose from: living room.\n"
      pipe.puts "living room"
      expected_output << "Great! The kitchen has an exit to the living room!\n"
      expected_output << "The exit from the kitchen to the living room is in which direction? (e.g., 'north', 'south', 'east', 'west')\n"
      pipe.puts "north"
      expected_output << "Awesome! The kitchen has a north exit that leads to the living room!\n"
      expected_output << "Please enter a description prefix for your room. (e.g. 'You are in the', 'You are in a', 'You are on the')\n"
      pipe.puts "You are in the"
      expected_output << "Excellent! Your description prefix will read like this: You are in the kitchen.\n"
      expected_output << "Please enter an objects list prefix for the objects in your room. (e.g., 'You can see')\n"
      pipe.puts "You can see"
      expected_output << "Fantastic! Your objects list prefix is: You can see.\n"
      expected_output << "Please enter an exits prefix for the exits in your room. (e.g., 'You can go')\n"
      pipe.puts "You can go"
      expected_output << "Marvelous! Your exit prefix will read like this: You can go north.\n"
      expected_output << "To add another room, please choose 'Add room' from the main menu. To play the game, please choose 'Play game'.\n"

      expected_output << main_menu
      pipe.puts "5"

      expected_output << "Loading Nashville Adventure...\n"
      expected_output << "You are in a living room.\n"
      expected_output << "You can go south.\n"
      expected_output << "The living room is a quiet place to read.\n"
      pipe.puts "go south"
      expected_output << "You are in the kitchen.\n"
      expected_output << "You can go north.\n"
      expected_output << "The kitchen is barely large enough for two people.\n"
      pipe.puts "go north"
      expected_output << "You are in a living room.\n"
      expected_output << "You can go south.\n"
      expected_output << "The living room is a quiet place to read.\n"

      pipe.puts "quit"
      expected_output = main_menu
      pipe.puts "6"
      expected_output << "Thanks for playing!\n"
      pipe.close_write
      shell_output = pipe.read
      pipe.close_read
      clear_rooms_table
      clear_exits_table
      clear_games_table
      clear_players_table
    end
    assert_equal expected_output, shell_output
  end
end
