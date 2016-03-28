class PlayerSeasonStatsDatatable
  include Datatable  

private

  def model_scope
    PlayerSeasonStat.joins(:player)
        .joins("join player_season_infos on player_season_infos.player_id = players.id and player_season_stats.season_id = player_season_infos.season_id")
        .joins("join teams on player_season_infos.team_id = teams.id")
        .joins("join d11_teams on player_season_infos.d11_team_id = d11_teams.id")
        .joins("join positions on player_season_infos.position_id = positions.id")
  end
  
  def filter_columns 
    %w[players.first_name players.last_name teams.name positions.name d11_teams.name]
  end

  def sort_columns
    %w[ranking players.last_name,players.first_name teams.name teams.name positions.sort_order
       games_started,games_substitute points_per_appearance goals goal_assists red_cards yellow_cards
       man_of_the_match,shared_man_of_the_match rating form_points points d11_teams.name]
  end
  
  def data

    objects.map do |player_season_stat|
      player_season_info = PlayerSeasonInfo.where(player: player_season_stat.player, season: player_season_stat.season).first
      team = player_season_info.team
      d11_team = player_season_info.d11_team      
      [
        player_season_stat.ranking,
        render_partial('players/player', { player: player_season_stat.player }),
        render_partial('teams/club_crest', { team: team, style: :icon }),
        render_partial('teams/team', { team: team, label: :code }),
        render_partial('positions/position', { position: player_season_info.position, label: :code }),
        "#{player_season_stat.games_started}/#{player_season_stat.games_substitute}",
        player_season_stat.points_per_appearance_s,
        player_season_stat.goals,
        player_season_stat.goal_assists,
        player_season_stat.yellow_cards,
        player_season_stat.red_cards,
        "#{player_season_stat.man_of_the_match}/#{player_season_stat.shared_man_of_the_match}",
        player_season_stat.rating_s,
        render_partial('players/player_form', { player: player_season_stat.player, season: player_season_stat.season }),
        player_season_stat.points,
        render_partial('d11_teams/d11_team', { d11_team: d11_team }),
      ] 
    end
  end

  def dataa
    objects.map do |team_table_stat|
      [
        team_table_stat.ranking,
        render_partial('team_table_stats/team_table_stat', { team_table_stat: team_table_stat }),
        
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
  
  def filter_scope_params(scope_params)
    scope_params = { "player_season_stats.season_id" => scope_params[:season_id] }
  end
  
end