require 'sqlite3'
require_relative '../../lib/database'


class RoomsModel

  def self.get_rooms(id)
    Database.execute("select room from rooms where game_id = ?", id).flatten
  end

  def self.get_all_rooms_info(game_id)
    Database.execute("select room, description from rooms where game_id = ?", game_id)
  end

  def self.get_all_room_info(id, game_id)
    Database.execute("select * from rooms where id = ? and game_id = ?", id, game_id)
  end

  def self.count(id)
    Database.execute("select count(room) from rooms where game_id = ?", id)
  end

  def self.create(game_id, room, description, description_prefix, objects_prefix, exits_prefix)
    Database.execute("insert into rooms (game_id, room, description, description_prefix, objects_prefix, exits_prefix) values (?,?,?,?,?,?)", game_id, room, description, description_prefix, objects_prefix, exits_prefix)
  end

  def self.is_start_of_game?(game_id)
    Database.execute("select count(id) from rooms where game_id = ?", game_id)[0][0]
  end

  def self.add_placeholder(game_id, room)
    Database.execute("insert into rooms (game_id, room) values (?,?)", game_id, room)
  end

  def self.create(game_id, room, description, description_prefix, objects_prefix, exits_prefix)
    Database.execute("insert into rooms (game_id, room, description, description_prefix, objects_prefix, exits_prefix) values (?,?,?,?,?,?)", game_id, room, description, description_prefix, objects_prefix, exits_prefix)
  end

  def self.insert_follow_up(game_id,room, description, description_prefix, objects_prefix, exits_prefix)
    Database.execute("update rooms set description=?, description_prefix=?, objects_prefix=?, exits_prefix=? where room=? and game_id = ?",description,description_prefix,objects_prefix,exits_prefix,room,game_id)
  end

  def self.get_start_location(game_id)
    Database.execute("select id from rooms where game_id = ?", game_id)
  end

  def self.get_room_prefix(location_id)
    Database.execute("select description_prefix from rooms where id = ?", location_id)
  end

  def self.get_room(location_id)
    Database.execute("select room from rooms where id = ?", location_id)
  end

  def self.get_directions_prefix(location_id)
    Database.execute("select exits_prefix from rooms where id = ?", location_id)
  end

  def self.get_description(location_id)
    Database.execute("select description from rooms where id = ?", location_id)
  end

  def self.edit_room_name(id, new_value)
    Database.execute("update rooms set room = ? where id = ?", new_value, id)
  end

  def self.edit_room_description(id, new_value)
    Database.execute("update rooms set description = ? where id = ?", new_value, id) 
  end

  def self.edit_room_description_prefix(id, new_value)
    Database.execute("update rooms set description_prefix = ? where id = ?", new_value, id) 
  end

  def self.edit_room_objects_prefix(id, new_value)
    Database.execute("update rooms set objects_prefix = ? where id = ?", new_value, id) 
  end

  def self.edit_room_exits_prefix(id, new_value)
    Database.execute("update rooms set exits_prefix = ? where id = ?", new_value, id) 
  end

  def self.get_exits_prefix(location_id)
    Database.execute("select exits_prefix from rooms where id = ?", location_id)
  end

  def self.get_description_prefix(location_id)
    Database.execute("select description_prefix from rooms where id = ?", location_id)
  end

  def self.get_objects_prefix(location_id)
    Database.execute("select objects_prefix from rooms where id = ?", location_id)
  end

end
