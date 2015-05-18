require 'sqlite3'

class PlayersModel
  def  self.create(game_id,location,player_name)
    Database.execute("insert into players (game_id,location,player_name) values (?,?,?)", game_id,location,player_name)
  end

  def self.count
    Database.execute("select count(id) from players")[0][0]
  end
end
