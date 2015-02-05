class CreateD11TeamTableStats < ActiveRecord::Migration
  def change
    create_table :d11_team_table_stats do |t|
      t.integer :d11_team_id
      t.integer :d11_league_id
      t.integer :d11_match_day_id
      t.integer :matches_played
      t.integer :matches_won
      t.integer :matches_drawn
      t.integer :matches_lost
      t.integer :goals_for
      t.integer :goals_against
      t.integer :goal_difference
      t.integer :points
      t.integer :ranking
      t.integer :home_matches_played
      t.integer :home_matches_won
      t.integer :home_matches_drawn
      t.integer :home_matches_lost
      t.integer :home_goals_for
      t.integer :home_goals_against
      t.integer :home_goal_difference
      t.integer :home_points
      t.integer :home_ranking
      t.integer :away_matches_played
      t.integer :away_matches_won
      t.integer :away_matches_drawn
      t.integer :away_matches_lost
      t.integer :away_goals_for
      t.integer :away_goals_against
      t.integer :away_goal_difference
      t.integer :away_points
      t.integer :away_ranking

      t.timestamps
    end
  end
end
