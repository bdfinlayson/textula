require 'sqlite3'
require_relative '../../lib/database'


class RoomsModel

  def self.get_rooms
    Database.execute("select room from rooms").flatten
  end

  def self.get_all_rooms_info
    Database.execute("select room, description from rooms")
  end

  def self.insert_into_database(game_id, room, description, description_prefix, objects_prefix, exits_prefix)
    Database.execute("insert into rooms (game_id, room, description, description_prefix, objects_prefix, exits_prefix) values (?,?,?,?,?,?)", game_id, room, description, description_prefix, objects_prefix, exits_prefix)
  end

  def self.is_start_of_game?
    Database.execute("select count(id) from rooms")[0][0]
  end

  def self.create_default_starting_room
    Database.execute("insert into rooms(room, description) values ('living room', 'A quiet place to read. You see a fireplace in one corner.')")
  end

end
