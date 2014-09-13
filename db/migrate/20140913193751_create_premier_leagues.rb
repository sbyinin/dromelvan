class CreatePremierLeagues < ActiveRecord::Migration
  def change
    create_table :premier_leagues do |t|
      t.integer :season_id
      t.string :name

      t.timestamps
    end
  end
end
