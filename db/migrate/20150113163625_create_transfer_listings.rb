class CreateTransferListings < ActiveRecord::Migration
  def change
    create_table :transfer_listings do |t|
      t.integer :transfer_day_id
      t.integer :player_id
      t.integer :team_id
      t.integer :position
      t.integer :goals
      t.integer :goal_assists
      t.integer :own_goals
      t.integer :goals_conceded
      t.integer :clean_sheets
      t.integer :yellow_cards
      t.integer :red_cards
      t.integer :man_of_the_match
      t.integer :shared_man_of_the_match
      t.integer :rating
      t.integer :points
      t.integer :games_started
      t.integer :games_substitute
      t.integer :games_did_not_participate
      t.integer :substitutions_on
      t.integer :substitutions_off
      t.integer :minutes_played
      t.integer :ranking
      t.boolean :new

      t.timestamps
    end
  end
end
