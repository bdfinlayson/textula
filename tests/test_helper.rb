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

  def start_menu
    "1. Create New Game\n2. Open Existing Game\n3. Quit\n"
  end

  def main_menu
    "1. Add room\n2. Add Object\n3. Edit Room\n4. Edit Object\n5. Quit\n"
  end
end
