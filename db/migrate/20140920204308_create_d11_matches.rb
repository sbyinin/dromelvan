class CreateD11Matches < ActiveRecord::Migration
  def change
    create_table :d11_matches do |t|
      t.integer :home_d11_team_id
      t.integer :away_d11_team_id
      t.integer :d11_match_day_id
      t.integer :home_team_goals
      t.integer :away_team_goals
      t.integer :home_match_points
      t.integer :away_match_points
      t.integer :status

      t.timestamps
    end
  end
end
