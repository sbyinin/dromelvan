class CreateSubstitutions < ActiveRecord::Migration
  def change
    create_table :substitutions do |t|
      t.integer :match_id
      t.integer :team_id
      t.integer :player_id
      t.integer :player_in_id
      t.integer :time
      t.integer :added_time

      t.timestamps
    end
  end
end
