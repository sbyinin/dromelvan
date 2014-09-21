class ChangeD11MatchColumnNames2 < ActiveRecord::Migration
  def change
    rename_column :d11_matches, :home_team_match_points, :home_team_points
    rename_column :d11_matches, :away_team_match_points, :away_team_points
  end
end
