require_relative '../test_helper.rb'
require 'highline/import'

class TestTextula < Minitest::Test

  def test_integration_0a_minimum_arguments_required?
    shell_output = ''
    expected_output = ''
    IO.popen('./textula' ) do |pipe|
      expected_output = "[Help] Run as: ./textula manage\n"
      shell_output = pipe.read
    end
    assert_equal expected_output, shell_output
  end

  def test_integration_0b_manage_argument_not_given?
    shell_output = ''
    expected_output = ''
    IO.popen('./textula blah') do |pipe|
      expected_output = "[Help] Run as: ./textula manage\n"
      shell_output = pipe.read
    end
    assert_equal expected_output, shell_output
  end

  def test_integration_0c_manage_argument_given_then_exit?
    shell_output = ''
    expected_output = ''
    IO.popen(' ./textula manage', 'r+') do |pipe|
      expected_output = main_menu
      pipe.puts "2"
      expected_output << "Thanks for playing!\n"
      pipe.close_write
      shell_output = pipe.read
    end
    assert_equal expected_output, shell_output
  end

  def test_integration_0d_manage_argument_given_then_add_room?
    shell_output = ''
    expected_output = ''
    IO.popen(' ./textula manage', 'r+') do |pipe|
      expected_output = main_menu
      pipe.puts "1"
      expected_output << "Welcome to the room creator!\n"
      pipe.close_write
      shell_output = pipe.read
    end
    assert_equal expected_output, shell_output
  end

  def test_integration_0d_manage_argument_given_then_add_room?
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
    end
    assert_equal expected_output, shell_output
  end

end
