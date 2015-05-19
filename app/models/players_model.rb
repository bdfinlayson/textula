require 'sqlite3'

class PlayersModel
  def  self.create(game_id,location,player_name)
    Database.execute("insert into players (game_id, location, player_name) values (?, ?, ?)", game_id, location, player_name)
  end

  def self.count
    Database.execute("select count(id) from players")[0][0]
  end

  def self.get_all_players
    Database.execute("select * from players")
  end

  def self.find_player(game_id)
    Database.execute("select * from players where game_id = ?", game_id)
  end
end
