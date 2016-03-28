class RemoveAppearances < ActiveRecord::Migration
  def change
    remove_column :player_season_stats, :appearances
    remove_column :player_career_stats, :appearances    
  end
end
