class Team < ActiveRecord::Base
  has_many :teams_per_leagues_and_seasons
  has_many :leagues_per_seasons, :through => :teams_per_leagues_and_seasons

  has_many :matches_home, :foreign_key => 'team_home_id', :class_name => 'Match'
  has_many :matches_away, :foreign_key => 'team_away_id', :class_name => 'Match'

  scope :seasons_count, -> {joins(:teams_per_leagues_and_seasons => {:leagues_per_season => :season}).count}

  def seasons
    Season.joins(:leagues_per_seasons => {:teams_per_leagues_and_seasons => :team}).where(:teams => {name: self.name})
  end

  def seasons_years
    self.seasons.map {|season| season.year}
  end
end
