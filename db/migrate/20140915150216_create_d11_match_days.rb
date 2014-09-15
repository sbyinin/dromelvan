class CreateD11MatchDays < ActiveRecord::Migration
  def change
    create_table :d11_match_days do |t|
      t.integer :d11_league_id
      t.date :date
      t.integer :match_day_number

      t.timestamps
    end
  end
end
