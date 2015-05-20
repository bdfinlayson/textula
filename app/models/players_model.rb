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

  def self.find_player(player_id)
    Database.execute("select * from players where id = ?", player_id)
  end

  def self.delete_player(player_id)
    Database.execute("delete from players where id = ?", player_id)
  end

  def self.edit_player_location(player_id, new_value)
    Database.execute("update players set location = ? where id = ?", new_value, player_id)
  end

  def self.edit_player_name(player_id, new_value)
    Database.execute("update players set player_name = ? where id = ?", new_value, player_id)
  end
end
