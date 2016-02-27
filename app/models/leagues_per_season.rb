class LeaguesPerSeason < ActiveRecord::Base
  belongs_to :league
  belongs_to :season

  has_many :teams_per_leagues_and_seasons
  has_many :teams, :through => :teams_per_leagues_and_seasons

  has_many :weeks

  after_create :save_season_and_league_names

  protected
    def save_season_and_league_names
      self.league_name = self.league.name
      self.season_year = self.season.year
      self.save
    end
end