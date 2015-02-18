class Game < ActiveRecord::Base
  require 'open-uri'
  paginates_per 50
  
  def self.getJSON
    game_platforms = [ "ps4", "xboxone", "ps3", "xbox360", "pc", "wii-u" ]
    
    headers =  {"X-Mashape-Key" => ENV["X_MASHAPE_KEY"]}
    base_url = "https://byroredux-metacritic.p.mashape.com/"
    
    games_hash = {}
    game_platforms.each do |platform|
      games_hash["#{platform}"] = JSON.load(open("#{base_url}game-list/#{platform}/new-releases", headers))
    end
    
    games_hash
  end
  
  def self.import
    games_hash = self.getJSON
    games_added = []
    games_hash.each do |platform, games|
      games["results"].each do |game|
        unless Game.where(name: game["name"]).first
          games_added << Game.create(name: game["name"], status: "Pending")
        end
      end
    end
    games_added
  end
end
