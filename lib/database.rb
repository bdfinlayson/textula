require 'sqlite3'

class Database

  def self.load_structure
    Database.execute("create table if not exists rooms(id integer primary key autoincrement, room text, description text, description_prefix text, objects_list_prefix text, exits_prefix text)")
    Database.execute("create table if not exists exits(id integer primary key autoincrement, parent_room_id integer, child_room_id integer, direction_from_parent_to_child text)")
  end

  def self.execute(*args)
    initialize_database unless defined?(@@db)
    @@db.execute(*args)
  end

  def self.initialize_database
    directory = "db"
    Dir.mkdir(directory) unless File.exist?(directory)
    environment = ENV["TEST"] ? "test" : "production"
    database = "#{directory}/database_#{environment}.sqlite"
    @@db = SQLite3::Database.new( database )
  end
end
