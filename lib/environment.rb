require 'active_record'
Dir["./lib/*.rb"].each { |file| require file }
Dir["./app/**/*.rb"].each { |file| require file }

class Environment

  def self.current
    ENV["TEST"] ? "test" : "production"
  end
end


connection_details = YAML::load(File.open('config/database.yml'))[Environment.current]
ActiveRecord::Base.establish_connection(connection_details)
