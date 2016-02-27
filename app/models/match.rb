class Match < ActiveRecord::Base
  belongs_to :week

  belongs_to :team_home, :class_name => 'Team'
  belongs_to :team_away, :class_name => 'Team'
end