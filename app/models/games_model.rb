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

  def self.edit_game_description(id, new_value)
    Database.execute("update games set description = ? where id = ?", new_value, id)
  end

  def self.edit_game_name(id, new_value)
    Database.execute("update games set name = ? where id = ?", new_value, id)
  end

  def self.delete_game(id)
    Database.execute("delete from games where id = ?", id)
  end

end
