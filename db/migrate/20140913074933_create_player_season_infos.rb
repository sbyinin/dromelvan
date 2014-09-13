class CreatePlayerSeasonInfos < ActiveRecord::Migration
  def change
    create_table :player_season_infos do |t|
      t.integer :player_id
      t.integer :season_id
      t.integer :team_id
      t.integer :d11_team_id
      t.integer :position_id
      t.integer :value

      t.timestamps
    end
  end
end
