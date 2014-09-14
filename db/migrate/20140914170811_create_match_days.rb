class CreateMatchDays < ActiveRecord::Migration
  def change
    create_table :match_days do |t|
      t.integer :premier_league_id
      t.date :date
      t.integer :match_day_number

      t.timestamps
    end
  end
end
