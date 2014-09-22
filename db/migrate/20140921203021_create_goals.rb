class CreateGoals < ActiveRecord::Migration
  def change
    create_table :goals do |t|
      t.integer :match_id
      t.integer :team_id
      t.integer :player_id
      t.integer :time
      t.integer :added_time
      t.boolean :penalty
      t.boolean :own_goal

      t.timestamps
    end
  end
end
