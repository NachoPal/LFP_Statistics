class Team < ActiveRecord::Base
  has_many :teams_per_leagues_and_seasons
  has_many :leagues_per_seasons, :through => :teams_per_leagues_and_seasons
end
