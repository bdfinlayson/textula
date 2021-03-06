require 'sqlite3'
require_relative '../../lib/database'

class Exit < ActiveRecord::Base

  def self.set_exit(choice, room, direction)
    child_room = Database.execute("select id from rooms where room = ?", "#{choice}").flatten
    parent_room = Database.execute("select id from rooms where room = ?", "#{room}").flatten
    Database.load_structure
    Database.execute("insert into exits (parent_room_id,child_room_id, direction_from_parent_to_child) values (?,?,?)", "#{parent_room[0]}", "#{child_room[0]}", "#{direction}")
  end

  def self.get_directions(location_id)
    Database.execute("select direction_from_parent_to_child from exits where parent_room_id = ?", location_id)
  end

  def self.get_new_location_id(direction, player_location)
    Database.execute("select child_room_id from exits where direction_from_parent_to_child = ? and parent_room_id = ?", direction, player_location)
  end

end
