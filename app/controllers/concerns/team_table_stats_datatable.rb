class TeamTableStatsDatatable
  include Datatable  

private

  def model_scope
    TeamTableStat.joins(:team)
  end
  
  def filter_columns 
    %w[teams.name]
  end

  def sort_columns
    %w[ranking teams.name
       home_matches_played home_goals_for home_goals_against home_goal_difference home_points
       away_matches_played away_goals_for away_goals_against away_goal_difference away_points
       matches_played matches_won matches_drawn matches_lost goals_for goals_against goal_difference form_points points]
  end
  
  def data
    objects.map do |team_table_stat|
      [
        team_table_stat.ranking,
        object_name_link(team_table_stat.team),
        
        team_table_stat.home_matches_played,
        team_table_stat.home_goals_for,
        team_table_stat.home_goals_against,
        (team_table_stat.home_goal_difference > 0 ? "+#{team_table_stat.home_goal_difference}" : team_table_stat.home_goal_difference),
        team_table_stat.home_points,

        team_table_stat.away_matches_played,
        team_table_stat.away_goals_for,
        team_table_stat.away_goals_against,
        (team_table_stat.away_goal_difference > 0 ? "+#{team_table_stat.away_goal_difference}" : team_table_stat.away_goal_difference),
        team_table_stat.away_points,
        
        team_table_stat.matches_played,
        team_table_stat.matches_won,
        team_table_stat.matches_drawn,
        team_table_stat.matches_lost,
        team_table_stat.goals_for,
        team_table_stat.goals_against,
        (team_table_stat.goal_difference > 0 ? "+#{team_table_stat.goal_difference}" : team_table_stat.goal_difference),
        render_partial('teams/team_form', { team: team_table_stat.team, match_day: team_table_stat.match_day}),
        team_table_stat.points
      ] 
    end
  end
  
end