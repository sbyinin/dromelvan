class RemoveFormPointsFromPlayerCareerStat < ActiveRecord::Migration
  def change
    remove_column :player_career_stats, :form_points
  end
end
