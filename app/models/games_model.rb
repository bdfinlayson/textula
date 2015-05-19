require 'sqlite3'
require_relative '../../lib/database'

class GamesModel

  def self.create(game_name, player_name, game_description)
    Database.load_structure
    Database.execute("insert into games (name,player,description) values (?,?,?)", game_name,player_name,game_description)
  end

  def self.count
    Database.execute("select count(id) from games")[0][0]
  end

  def self.get_id(name)
    Database.execute("select id from games where name like ?", name)
  end

  def self.get_all_games
    Database.execute("select all name from games")
  end

  def self.find_game(name)
    Database.execute("select * from games where name = ?", name)
  end

end
