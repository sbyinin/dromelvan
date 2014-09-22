class CreateCards < ActiveRecord::Migration
  def change
    create_table :cards do |t|
      t.integer :match_id
      t.integer :team_id
      t.integer :player_id
      t.integer :time
      t.integer :added_time
      t.integer :card_type

      t.timestamps
    end
  end
end
