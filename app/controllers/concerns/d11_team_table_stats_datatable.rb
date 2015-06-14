class D11TeamTableStatsDatatable
  include Datatable  

private

  def model_scope
    D11TeamTableStat.joins(:d11_team)
  end
  
  def filter_columns 
    %w[d11_teams.name]
  end

  def sort_columns
    %w[ranking d11_teams.name
       home_matches_played home_goals_for home_goals_against home_goal_difference home_points
       away_matches_played away_goals_for away_goals_against away_goal_difference away_points
       matches_played matches_won matches_drawn matches_lost goals_for goals_against goal_difference form_points points]
  end
  
  def data
    objects.map do |d11_team_table_stat|
      [
        d11_team_table_stat.ranking,
        render_partial('d11_team_table_stats/d11_team_table_stat', { d11_team_table_stat: d11_team_table_stat }),
        
        d11_team_table_stat.home_matches_played,
        d11_team_table_stat.home_goals_for,
        d11_team_table_stat.home_goals_against,
        (d11_team_table_stat.home_goal_difference > 0 ? "+#{d11_team_table_stat.home_goal_difference}" : d11_team_table_stat.home_goal_difference),
        d11_team_table_stat.home_points,

        d11_team_table_stat.away_matches_played,
        d11_team_table_stat.away_goals_for,
        d11_team_table_stat.away_goals_against,
        (d11_team_table_stat.away_goal_difference > 0 ? "+#{d11_team_table_stat.away_goal_difference}" : d11_team_table_stat.away_goal_difference),
        d11_team_table_stat.away_points,
        
        d11_team_table_stat.matches_played,
        d11_team_table_stat.matches_won,
        d11_team_table_stat.matches_drawn,
        d11_team_table_stat.matches_lost,
        d11_team_table_stat.goals_for,
        d11_team_table_stat.goals_against,
        (d11_team_table_stat.goal_difference > 0 ? "+#{d11_team_table_stat.goal_difference}" : d11_team_table_stat.goal_difference),
        render_partial('d11_teams/d11_team_form', { d11_team: d11_team_table_stat.d11_team, d11_match_day: d11_team_table_stat.d11_match_day}),
        d11_team_table_stat.points
      ] 
    end
  end
  
end