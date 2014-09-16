class CreateMatches < ActiveRecord::Migration
  def change
    create_table :matches do |t|
      t.integer :home_team_id
      t.integer :away_team_id
      t.integer :match_day_id
      t.integer :stadium_id
      t.integer :home_team_goals
      t.integer :away_team_goals
      t.datetime :datetime
      t.string :elapsed
      t.integer :status
      t.integer :whoscored_id

      t.timestamps
    end
  end
end
