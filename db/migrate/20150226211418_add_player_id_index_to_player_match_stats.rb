class AddPlayerIdIndexToPlayerMatchStats < ActiveRecord::Migration
  def change
    add_index :player_match_stats, :player_id
  end
end
