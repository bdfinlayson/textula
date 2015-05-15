require 'sqlite3'
require_relative '../../lib/rooms_database'
require_relative '../../lib/exits_database'

class ExitsModel

  def self.set_exit(choice, room, direction)
    child_room = RoomsDatabase.execute("select id from rooms where room like ?", "#{room}").flatten
    parent_room = RoomsDatabase.execute("select id from rooms where room like ?", "#{choice}").flatten
    ExitsDatabase.load_structure
    ExitsDatabase.execute("insert into exits (child_room_id,parent_room_id, direction_from_parent_to_child) values (?,?,?)", "#{child_room[0]}", "#{parent_room[0]}", "#{direction}")
  end

end
