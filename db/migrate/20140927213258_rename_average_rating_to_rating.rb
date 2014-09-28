class RenameAverageRatingToRating < ActiveRecord::Migration
  def change
    rename_column :player_season_stats, :average_rating, :rating
  end
end
