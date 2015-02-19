class AddTeamGoalsToD11TeamCareerSquadStat < ActiveRecord::Migration
  def change
    add_column :d11_team_career_squad_stats, :team_goals, :integer
  end
end
