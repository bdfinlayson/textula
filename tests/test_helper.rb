require 'rubygems'
require 'bundler/setup'
require 'minitest/reporters'
require 'minitest/autorun'
require_relative '../lib/environment'
ENV["TEST"] = "true"

reporter_options = { color: true }

Minitest::Reporters.use!
[Minitest::Reporters::DefaultReporter.new(reporter_options)]

class Minitest::Test
  def setup
    Database.load_structure
  end

  def teardown
    File.delete("db/database_test.sqlite")
    Database.initialize_database
  end

  def clear_all
    Database.execute("delete from players")
    Database.execute("delete from games")
    Database.execute("delete from exits")
    Database.execute("delete from rooms")
  end

  def clear_rooms_table
    Database.execute("delete from rooms")
  end

  def clear_exits_table
    Database.execute("delete from exits")
  end

  def clear_games_table
    Database.execute("delete from games")
  end

  def clear_players_table
    Database.execute("delete from players")
  end

  def create_room(id, room, description)
    Database.execute("insert into rooms (game_id,room,description) values (?,?,?)", id, room, description)
  end

  def start_menu
    "1. Create New Game\n2. Edit Existing Game\n3. Play Saved Game\n4. Quit\n"
  end

  def main_menu
    "1. Add room\n2. Add object\n3. Edit room\n4. Edit object\n5. Play game\n6. Quit\n"
  end
end
