require 'rubygems'
require 'bundler/setup'
require 'minitest/reporters'
require 'minitest/autorun'
Dir["./app/**/*.rb"].each { |file| require file }
Dir["./lib/*.rb"].each { |file| require file }
ENV["TEST"] = "true"

reporter_options = { color: true }

Minitest::Reporters.use!
[Minitest::Reporters::DefaultReporter.new(reporter_options)]

class Minitest::Test
  def setup
    RoomsDatabase.load_structure
  end

  def clear_table
    RoomsDatabase.execute("delete from rooms")
  end

  def create_room(room,description)
    RoomsDatabase.execute("insert into rooms (room,description) values (?,?)", room, description)
  end

  def main_menu
    "1. Add room\n2. Quit\n"
  end
end
