require 'sqlite3'

class RoomsDatabase

  def self.load_structure
    RoomsDatabase.execute("create table if not exists rooms(id integer primary key autoincrement, room text, description text)")
  end

  def self.execute(*args)
    initialize_database unless defined?(@@db)
    @@db.execute(*args)
  end

  def self.initialize_database
    directory = "db"
    Dir.mkdir(directory) unless File.exist?(directory)
    environment = ENV["TEST"] ? "test" : "production"
    database = "#{directory}/rooms_database_#{environment}.sqlite"
    @@db = SQLite3::Database.new( database )
  end

end
