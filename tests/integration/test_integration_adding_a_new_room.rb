require_relative '../test_helper'
require 'sqlite3'

class AddingANewRoomTest < Minitest::Test

  def test_integration_adding_a_new_room_0a_manage_argument_given_then_add_room?
    shell_output = ''
    expected_output = ''
    IO.popen(' ./textula manage', 'r+') do |pipe|
      expected_output = main_menu
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
      pipe.close_write
      shell_output = pipe.read
      pipe.close_read
      clear_rooms_table
      clear_exits_table
    end
    assert_equal expected_output, shell_output
  end

end
