class AddTeamGoalsToTeamSeasonSquadStats < ActiveRecord::Migration
  def change
    add_column :team_season_squad_stats, :team_goals, :integer
  end
end
