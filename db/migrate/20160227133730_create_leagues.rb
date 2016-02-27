class CreateLeagues < ActiveRecord::Migration
  def change
    create_table :leagues do |t|
      t.string :name
      t.timestamps null: false
    end

    create_table :seasons do |t|
      t.integer :year
      t.timestamps null: false
    end

    create_table :leagues_per_seasons do |t|
      t.string :name
      t.belongs_to :league, index: true
      t.belongs_to :season, index: true
      t.timestamps null: false
    end

  end
end
