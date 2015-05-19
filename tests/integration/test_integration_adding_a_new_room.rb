require_relative '../test_helper'
require 'sqlite3'

class AddingANewRoomTest < Minitest::Test

  def test_integration_adding_a_new_room_0a_manage_argument_given_then_add_room?
    clear_all
    shell_output = ''
    expected_output = ''
    IO.popen(' ./textula start', 'r+') do |pipe|
      expected_output = start_menu
      pipe.puts "1"
      expected_output << "Welcome to Textula!\n"
      expected_output << "The Textula game engine will now walk you through creating your own text-adventure game!\n"
      expected_output << "So lets get started!\n"
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
      expected_output << "Your game currently has no rooms.\n"
      expected_output << "What is the name of the room you want to add.\n"
      pipe.puts "living room"
      expected_output << "You created a living room.\n"
      expected_output << "What is the description of your living room.\n"
      pipe.puts "It is a large space"
      expected_output << "You created a description for the living room. It reads: It is a large space.\n"
      expected_output << "What rooms does the living room lead to? You currently have no rooms to choose from, but you can go ahead and declare a room now!\n"
      pipe.puts "kitchen"
      expected_output << "Great! The living room has an exit to the kitchen! In a moment we will ask you for more information about the room called kitchen!\n"
      expected_output << "The exit from the living room to the kitchen is in which direction? (e.g., 'north', 'south', 'east', 'west')\n"
      pipe.puts "north"
      expected_output << "And the opposite direction of north is what?\n"
      pipe.puts "south"
      expected_output << "Awesome! The living room has a north exit that leads to the kitchen!\n"
      expected_output << "The kitchen also has a south exit that leads to the living room!\n"
      expected_output << "Please enter a description prefix for your room. (e.g. 'You are in the', 'You are in a', 'You are on the')\n"
      pipe.puts "You are in the"
      expected_output << "Excellent! Your description prefix will read like this: You are in the living room.\n"
      expected_output << "Please enter an objects list prefix for the objects in your room. (e.g., 'You can see')\n"
      pipe.puts "You can see"
      expected_output << "Fantastic! Your objects list prefix is: You can see.\n"
      expected_output << "Please enter an exits prefix for the exits in your room. (e.g., 'You can go')\n"
      pipe.puts "You can go"
      expected_output << "Marvelous! Your exit prefix will read like this: You can go north.\n"
      expected_output << "Earlier you created a room called kitchen that did not exist previously. Please add more information about this room.\n"
      expected_output << "What is the description of your kitchen?\n"
      pipe.puts "It is barely large enough for two people"
      expected_output << "You created a description for kitchen. It reads: It is barely large enough for two people.\n"
      expected_output << "The kitchen already has a south exit that leads to the living room.\n"
      expected_output << "Please enter a description prefix for your room. (e.g. 'You are in the', 'You are in a', 'You are on the')\n"
      pipe.puts "You are in the"
      expected_output << "Excellent! Your description prefix will read like this: You are in the kitchen.\n"
      expected_output << "Please enter an objects list prefix for the objects in your room. (e.g., 'You can see')\n"
      pipe.puts "You can see"
      expected_output << "Fantastic! Your objects list prefix is: You can see.\n"
      expected_output << "Please enter an exits prefix for the exits in your room. (e.g., 'You can go')\n"
      pipe.puts "You can go"
      expected_output << "Marvelous! Your exit prefix will read like this: You can go south.\n"
      expected_output << "To add another room, please choose 'Add room' from the main menu. To play the game, please choose 'Play game'.\n"
      expected_output << main_menu
      pipe.puts "6"
      expected_output << "Thanks for playing!\n"
      pipe.close_write
      shell_output = pipe.read
      pipe.close_read
      clear_all
    end
    assert_equal expected_output, shell_output
  end
end
