class AssociationTeamsAndLeaguesPerSeason < ActiveRecord::Migration
  def change

    create_table :teams do |t|
      t.string :name
    end

    create_table :teams_per_leagues_and_seasons do |t|
      t.belongs_to :leagues_per_season, index: true
      t.belongs_to :team, index: true
    end
  end
end
