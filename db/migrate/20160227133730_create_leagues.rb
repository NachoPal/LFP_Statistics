class CreateLeagues < ActiveRecord::Migration
  def change
    create_table :leagues do |t|
      t.string :name
    end

    create_table :seasons do |t|
      t.integer :year
    end

    create_table :leagues_per_seasons do |t|
      t.belongs_to :league, index: true
      t.belongs_to :season, index: true
      t.string :league_name
      t.integer :season_year
    end
  end
end
