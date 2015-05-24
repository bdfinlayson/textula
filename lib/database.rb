require 'sqlite3'

class Database

  def self.load_structure
    Database.execute("create table if not exists rooms(id integer primary key autoincrement, game_id integer, room text, description text, description_prefix text, objects_prefix text, exits_prefix text, foreign key (game_id) references games(id))")
    Database.execute("create table if not exists exits(id integer primary key autoincrement, parent_room_id integer, child_room_id integer, direction_from_parent_to_child text, foreign key (parent_room_id) references rooms(id), foreign key (child_room_id) references rooms(id))")
    Database.execute("create table if not exists games(id integer primary key autoincrement, name text, player text, description text)")
    Database.execute("create table if not exists players(id integer primary key autoincrement, game_id integer, location integer, player_name text, foreign key (game_id) references games(id))")
  end

  def self.execute(*args)
    initialize_database unless defined?(@@db)
    #@@db.execute('PRAGMA foreign_keys = ON')
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
