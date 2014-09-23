class CreatePlayerMatchStats < ActiveRecord::Migration
  def change
    create_table :player_match_stats do |t|
      t.integer :player_id
      t.integer :match_id
      t.integer :team_id
      t.integer :d11_team_id
      t.integer :position_id
      t.string :played_position
      t.integer :lineup
      t.integer :substitution_on_time
      t.integer :substitution_off_time
      t.integer :goals
      t.integer :goal_assists
      t.integer :own_goals
      t.integer :goals_conceded
      t.integer :yellow_card_time
      t.integer :red_card_time
      t.boolean :man_of_the_match
      t.boolean :shared_man_of_the_match
      t.integer :rating
      t.integer :points

      t.timestamps
    end
  end
end
