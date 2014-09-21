class ChangeD11MatchColumnNames < ActiveRecord::Migration
  def change
    rename_column :d11_matches, :home_match_points, :home_team_match_points
    rename_column :d11_matches, :away_match_points, :away_team_match_points
  end
end
