require_relative '../test_helper'

class AddingANewRoomTest < Minitest::Test

  def test_integration_adding_a_new_room_0a_manage_argument_given_then_add_room?
    shell_output = ''
    expected_output = ''
    IO.popen(' ./textula manage', 'r+') do |pipe|
      expected_output = main_menu
      pipe.puts "1"
      expected_output << "Welcome to the room creator!\n"
      expected_output << "What is the name of the room you want to add.\n"
      pipe.puts "kitchen"
      expected_output << "You created a kitchen.\n"
      expected_output << "What is the description of your kitchen.\n"
      pipe.puts "A quiet place to read. You see a fireplace in one corner"
      expected_output << "You created a description for kitchen. It reads: A quiet place to read. You see a fireplace in one corner.\n"
      expected_output << "What is the kitchen next to? You can choose from: living room.\n"
      pipe.puts "living room"
      expected_output << "Great! The kitchen is next to the living room!\n"
      pipe.close_write
      shell_output = pipe.read
      pipe.close_read
    end
    assert_equal expected_output, shell_output
  end

end