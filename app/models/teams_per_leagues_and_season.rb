class TeamsPerLeaguesAndSeason < ActiveRecord::Base
  belongs_to :team
  belongs_to :leagues_per_season
end