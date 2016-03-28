class AddPointsPerAppearanceToModels < ActiveRecord::Migration
  def change
    add_column :d11_team_career_squad_stats, :points_per_appearance, :integer
    add_column :d11_team_match_squad_stats, :points_per_appearance, :integer
    add_column :d11_team_season_squad_stats, :points_per_appearance, :integer    
    add_column :team_career_squad_stats, :points_per_appearance, :integer
    add_column :team_match_squad_stats, :points_per_appearance, :integer
    add_column :team_season_squad_stats, :points_per_appearance, :integer
    add_column :transfer_listings, :points_per_appearance, :integer
  end
end
