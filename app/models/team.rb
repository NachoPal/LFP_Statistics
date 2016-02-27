class Team < ActiveRecord::Base
  has_many :teams_per_leagues_and_seasons
  has_many :leagues_per_seasons, :through => :teams_per_leagues_and_seasons

  has_many :matches_home, :foreign_key => 'team_home_id', :class_name => 'Match'
  has_many :matches_away, :foreign_key => 'team_away_id', :class_name => 'Match'
end
