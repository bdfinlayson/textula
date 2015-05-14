require 'sqlite3'
require_relative '../../lib/rooms_database'

class RoomsModel

  def self.get_rooms
    RoomsDatabase.execute("select room from rooms").flatten
  end

  def self.update_database(room, description, next_to)
    RoomsDatabase.execute("insert into rooms (room, description, next_to) values ('#{room}','#{description}','#{next_to}')")
  end

  def self.get_relation(choice, room)
    relation = RoomsDatabase.execute("select room from rooms where room like ?", "#{choice}").flatten
    RoomsDatabase.execute("update rooms set next_to = '#{relation[relation.index(choice)]}' where room = '#{room}'")
  end

  def self.is_start_of_game?
    RoomsDatabase.execute("select count(id) from rooms")[0][0]
  end

  def self.create_default_starting_room
    RoomsDatabase.execute("insert into rooms(room, description) values ('living room', 'A quiet place to read. You see a fireplace in one corner.')")
  end

end
