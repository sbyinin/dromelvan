class AddTeamGoalsToTeamCareerSquadStats < ActiveRecord::Migration
  def change
    add_column :team_career_squad_stats, :team_goals, :integer
  end
end
