class AddFieldsToPlayerStatsSummaries < ActiveRecord::Migration
  def change
    add_column :player_season_stats, :appearances, :integer
    add_column :player_career_stats, :appearances, :integer    
    add_column :player_season_stats, :form_points, :integer
    add_column :player_career_stats, :form_points, :integer
    add_column :player_season_stats, :points_per_appearance, :integer
    add_column :player_career_stats, :points_per_appearance, :integer
    add_column :player_career_stats, :seasons, :integer
    add_column :player_career_stats, :points_per_season, :integer
  end
end
