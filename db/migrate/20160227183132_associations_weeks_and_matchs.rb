class AssociationsWeeksAndMatchs < ActiveRecord::Migration
  def change

    create_table :weeks do |t|
      t.integer :round
      t.belongs_to :leagues_per_season, index: true
    end

    create_table :matches do |t|
      t.belongs_to :week, index: true
      t.references :team_home
      t.references :team_away

      t.integer :goals_home
      t.integer :goals_away
      t.integer :possession_home
      t.integer :possession_away
      t.integer :shoot_home
      t.integer :shoot_away
      t.integer :shoot_at_goal_home
      t.integer :shoot_at_goal_away
      t.integer :goalposts_home
      t.integer :goalposts_away
      t.integer :yellow_cards_home
      t.integer :yellow_cards_away
      t.integer :red_cards_home
      t.integer :red_cards_away
      t.integer :fouls_done_home
      t.integer :fouls_done_away
      t.integer :fouls_received_home
      t.integer :fouls_received_away
      t.integer :lost_balls_home
      t.integer :lost_balls_away
      t.integer :recovered_balls_home
      t.integer :recovered_balls_away
      t.integer :offside_home
      t.integer :offside_away
      t.integer :penalty_home
      t.integer :penalty_away
      t.integer :goalkeeper_action_home
      t.integer :goalkeeper_action_away
    end
  end
end
