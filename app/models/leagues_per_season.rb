class LeaguesPerSeason < ActiveRecord::Base
  belongs_to :league
  belongs_to :season
end