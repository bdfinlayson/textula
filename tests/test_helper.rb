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
    Database.load_structure
  end

  def clear_rooms_table
    Database.execute("delete from rooms")
  end

  def clear_exits_table
    Database.execute("delete from exits")
  end

  def clear_exits_table
    Database.execute("delete from games")
  end

  def create_room(room,description)
    Database.execute("insert into rooms (room,description) values (?,?)", room, description)
  end

  def main_menu
    "1. Create New Game\n2. Add room\n3. Play Game\n4. Quit\n"
  end
end
