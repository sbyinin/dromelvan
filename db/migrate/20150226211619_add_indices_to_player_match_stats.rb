class AddIndicesToPlayerMatchStats < ActiveRecord::Migration
  def change
    add_index :player_match_stats, :match_id
    add_index :player_match_stats, :team_id
    add_index :player_match_stats, :d11_team_id
    add_index :player_match_stats, :position_id
  end
end
