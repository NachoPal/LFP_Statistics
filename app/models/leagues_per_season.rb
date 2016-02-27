class LeaguesPerSeason < ActiveRecord::Base
  belongs_to :league
  belongs_to :season

  has_many :teams_per_leagues_and_seasons
  has_many :teams, :through => :teams_per_leagues_and_seasons
end