require 'sqlite3'
require_relative '../../lib/rooms_database'
require_relative '../../lib/exits_database'


class RoomsModel

  def self.get_rooms
    RoomsDatabase.execute("select room from rooms").flatten
  end

  def self.get_all_rooms_info
    RoomsDatabase.execute("select room, description from rooms")
  end

  def self.insert_into_database(room, description)
    RoomsDatabase.execute("insert into rooms (room, description) values (?,?)", "#{room}","#{description}")
  end

  def self.is_start_of_game?
    RoomsDatabase.execute("select count(id) from rooms")[0][0]
  end

  def self.create_default_starting_room
    RoomsDatabase.execute("insert into rooms(room, description) values ('living room', 'A quiet place to read. You see a fireplace in one corner.')")
  end

end
