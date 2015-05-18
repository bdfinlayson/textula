require 'sqlite3'
require_relative '../../lib/database'


class RoomsModel

  def self.get_rooms
    Database.execute("select room from rooms").flatten
  end

  def self.get_all_rooms_info
    Database.execute("select room, description from rooms")
  end

  def self.create(game_id, room, description, description_prefix, objects_prefix, exits_prefix)
    Database.execute("insert into rooms (game_id, room, description, description_prefix, objects_prefix, exits_prefix) values (?,?,?,?,?,?)", game_id, room, description, description_prefix, objects_prefix, exits_prefix)
  end

  def self.is_start_of_game?
    Database.execute("select count(id) from rooms")[0][0]
  end

  def self.add_placeholder(game_id, room)
    Database.execute("insert into rooms (game_id, room) values (?,?)", game_id, room)
  end

  def self.create(game_id, room, description, description_prefix, objects_prefix, exits_prefix)
    Database.execute("insert into rooms (game_id, room, description, description_prefix, objects_prefix, exits_prefix) values (?,?,?,?,?,?)", game_id, room, description, description_prefix, objects_prefix, exits_prefix)
  end

  def self.insert_follow_up(room, description, description_prefix, objects_prefix, exits_prefix)
    Database.execute("update rooms set description=?, description_prefix=?, objects_prefix=?, exits_prefix=? where room=?",description,description_prefix,objects_prefix,exits_prefix,room)
  end

end
