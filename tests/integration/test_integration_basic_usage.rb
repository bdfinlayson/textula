require_relative '../test_helper.rb'
require 'highline/import'

class BasicUsage < Minitest::Test

  def test_integration_basic_usage_0a_minimum_arguments_required?
    shell_output = ''
    expected_output = ''
    IO.popen('./textula' ) do |pipe|
      expected_output = "[Help] Run as: ./textula start\n"
      shell_output = pipe.read
      pipe.close_read
    end
    assert_equal expected_output, shell_output
  end

  def test_integration_basic_usage_0b_wrong_argument_given?
    shell_output = ''
    expected_output = ''
    IO.popen('./textula blah') do |pipe|
      expected_output = "[Help] Run as: ./textula start\n"
      shell_output = pipe.read
      pipe.close_read
    end
    assert_equal expected_output, shell_output
  end

  def test_integration_basic_usage_0c_manage_argument_given_then_exit?
    shell_output = ''
    expected_output = ''
    IO.popen(' ./textula start', 'r+') do |pipe|
      expected_output = start_menu
      pipe.puts "3"
      expected_output << "Thanks for playing!\n"
      pipe.close_write
      shell_output = pipe.read
      pipe.close_read
    end
    assert_equal expected_output, shell_output
  end

  def test_integration_basic_usage_0d_manage_and_invalid_arg_given?
    shell_output = ""
    expected_output = ""
    IO.popen('./textula start blah') do |pipe|
      expected_output = "[Help] Run as: ./textula start\n"
      shell_output = pipe.read
      pipe.close_read
    end
    assert_equal expected_output, shell_output
  end
end
