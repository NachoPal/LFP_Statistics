class AssociationsWeeksAndMatchs < ActiveRecord::Migration
  def change

    create_table :weeks do |t|
      t.integer :round
      t.belongs_to :leagues_per_season, index: true
      t.timestamps null: false
    end

    create_table :matches do |t|
      t.belongs_to :week, index: true
      t.references :team_home
      t.references :team_away
      t.timestamps null: false
    end

  end
end
