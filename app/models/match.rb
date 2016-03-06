class Match < ActiveRecord::Base
  belongs_to :week

  belongs_to :team_home, :class_name => 'Team'
  belongs_to :team_away, :class_name => 'Team'

  scope :team_home, ->(team_name) {where(team_home_id: Team.where(name: team_name))}
  scope :team_away, ->(team_name) {where(team_away_id: Team.where(name: team_name))}
  scope :teams, ->(team_name_home, team_name_away) {where(team_home_id: Team.where(name: team_name_home),
                                                          team_away_id: Team.where(name: team_name_away))}

  def self.goals_bet
    group(:goals_home).count
  end
end