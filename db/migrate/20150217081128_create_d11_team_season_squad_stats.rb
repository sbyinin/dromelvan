class CreateD11TeamSeasonSquadStats < ActiveRecord::Migration
  def change
    create_table :d11_team_season_squad_stats do |t|
      t.integer :d11_team_id
      t.integer :season_id
      t.integer :team_goals
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

      t.timestamps
    end
  end
end
