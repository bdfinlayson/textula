require 'sqlite3'

class Database
  def self.load_structure
    Database.execute <<-SQL
    create table if not exists rooms(
      id integer primary key autoincrement,
      room text,
      description text
    );
    SQL
  end

  def self.execute(*args)
    initialize_database unless defined?(@@db)
    @@db.execute(*args)
  end

  def self.initialize_database
    environment = ENV["TEST"] ? "test" : "production"
    database = "db/rooms_#{environment}.sqlite"
    @@db = SQLite3::Database.new(database)
  end
end
