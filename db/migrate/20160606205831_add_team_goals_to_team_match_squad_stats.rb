class AddTeamGoalsToTeamMatchSquadStats < ActiveRecord::Migration
  def change
    add_column :team_match_squad_stats, :team_goals, :integer
  end
end
