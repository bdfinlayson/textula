require 'sqlite3'
require_relative '../../lib/database'

class GameModel

  def self.add(game_name, player_name, game_description)
    Database.execute("insert into games (name,player,description) values (?,?,?)", game_name,player_name,game_description)
  end

  def self.count
    Database.execute("select count(id) from games")[0][0]
  end

end
