class UploadMatchStatsFile < UploadXMLFile
  def initialize(match)
    @match = match 
  end
  
  private
    def handle_data(xml)
      Match.transaction do
        player_match_stats = {}
        @match.player_match_stats.each do |player_match_stat|
          player_match_stat.reset
          player_match_stats[player_match_stat.player.whoscored_id] = player_match_stat
        end
        @match.goals.delete_all
        @match.cards.delete_all
        @match.substitutions.delete_all
        
        match_data = parse_team_data(xml.xpath("//homeTeam"))
        away_team_data = parse_team_data(xml.xpath("//awayTeam"))
        match_data[:players].concat(away_team_data[:players])
        match_data[:mom] = { @match.home_team => [], @match.away_team => []}
        match_data[:goals].concat(away_team_data[:goals])
        match_data[:cards].concat(away_team_data[:cards])
        match_data[:substitutions].concat(away_team_data[:substitutions])  

        match_data[:players].each do |player_data|
          player_match_stat = player_match_stats[player_data[:whoscored_id]]
          if player_match_stat.nil?
            player = Player.where(whoscored_id: player_data[:whoscored_id]).take
            player_season_info = PlayerSeasonInfo.where(player: player, season: Season.current).take
            player_match_stat = PlayerMatchStat.create(player: player, match: @match, team: player_season_info.team, d11_team: player_season_info.d11_team, position: player_season_info.position)
            player_match_stats[player.whoscored_id] = player_match_stat
          end
          player_match_stat.lineup = player_data[:participated]
          player_match_stat.goal_assists = player_data[:assists]
          player_match_stat.rating = player_data[:rating]
          
          mom_player_match_stat = match_data[:mom][player_match_stat.team].first
          if mom_player_match_stat.nil? || mom_player_match_stat.rating < player_match_stat.rating
            match_data[:mom][player_match_stat.team] = [ player_match_stat ]
          elsif mom_player_match_stat.rating == player_match_stat.rating
            match_data[:mom][player_match_stat.team].concat([ player_match_stat ])
          end
        end
        
        match_data[:mom].values.each do |mom_player_match_stats|
          mom_player_match_stats.each do |mom_player_match_stat|
            if match_data[:mom][mom_player_match_stat.team].count > 1
              mom_player_match_stat.shared_man_of_the_match = true
            else
              mom_player_match_stat.man_of_the_match = true
            end
          end
        end        
   
        match_data[:goals].each do |goal_data|
          player_match_stat = player_match_stats[goal_data[:whoscored_id]]
          goal = Goal.create(match: @match, team: goal_data[:team], player: player_match_stat.player, time: goal_data[:time], added_time: 0, penalty: goal_data[:penalty], own_goal: goal_data[:own_goal])
          if goal.own_goal?
            player_match_stat.own_goals += 1
          else
            player_match_stat.goals += 1
          end
        end
        # Do valid? to make sure match.update_goals is done before player stats are calculated.
        @match.valid?

        match_data[:cards].each do |card_data|
          player_match_stat = player_match_stats[card_data[:whoscored_id]]
          card = Card.create(match: @match, team: card_data[:team], player: player_match_stat.player, time: card_data[:time], card_type: card_data[:type])
          if card.yellow?
            player_match_stat.yellow_card_time = card.time
          else
            player_match_stat.red_card_time = card.time
          end
        end
        
        match_data[:substitutions].each do |substitution_data|
          out_player_match_stat = player_match_stats[substitution_data[:out_whoscored_id]]
          in_player_match_stat = player_match_stats[substitution_data[:in_whoscored_id]]
          substitution = Substitution.create(match: @match, team: substitution_data[:team], player: out_player_match_stat.player, player_in: in_player_match_stat.player, time: substitution_data[:time])
          out_player_match_stat.substitution_off_time = substitution.time
          in_player_match_stat.substitution_on_time = substitution.time          
        end
        
        player_match_stats.values.each do |player_match_stat|
          if player_match_stat.position.defender?
            player_match_stat.goals_conceded = @match.goals_against(player_match_stat.team)
          end          
          player_match_stat.save
          PlayerSeasonStat.where(player: player_match_stat.player, season: @match.match_day.premier_league.season).take.save
          PlayerCareerStat.where(player: player_match_stat.player).take.save
        end
                        
        @match.team_match_squad_stats.each do |team_match_squad_stat|
          team_match_squad_stat.save
        end
        
        @match.match_day.d11_match_day.d11_matches.each do |d11_match|
          d11_match.d11_team_match_squad_stats.each do |d11_team_match_squad_stat|
            d11_team_match_squad_stat.save
          end
          d11_match.save
          #D11TeamTableStat.update_stats_from(d11_match)
        end
        
        @match.status = :finished
        @match.save
        
#        PlayerSeasonStat.update_rankings(@match.match_day.premier_league.season)
#        TeamTableStat.update_stats_from(@match)
#        TeamTableStat.update_rankings_from(@match.match_day)
      end      
    end
    
    def parse_team_data(team_xml)
      team_data = {}
      team_name = team_xml.xpath("name").text
      team = Team.where(name: team_name).take

      team_data[:players] = []
      team_xml.xpath("players/playerMatchStatistics").each do |player_match_statistic|
        whoscored_id = player_match_statistic.xpath("whoScoredId").text.to_i
        participated = player_match_statistic.xpath("participated").text.to_i
        assists = player_match_statistic.xpath("assists").text.to_i
        rating = player_match_statistic.xpath("rating").text.to_i

        team_data[:players].concat([ { team: team, whoscored_id: whoscored_id, participated: participated, assists: assists, rating: rating } ])
      end
      
      team_data[:goals] = []
      team_xml.xpath("goals/goal").each do |goal|
        whoscored_id = goal.xpath("whoScoredId").text.to_i
        penalty = goal.xpath("penalty").text == "true"
        own_goal = goal.xpath("ownGoal").text == "true"
        time = goal.xpath("time").text.to_i
        
        team_data[:goals].concat([ { team: team, whoscored_id: whoscored_id, penalty: penalty, own_goal: own_goal, time: time } ])
      end

      team_data[:cards] = []
      team_xml.xpath("cards/card").each do |card|
        whoscored_id = card.xpath("whoScoredId").text.to_i
        type = (card.xpath("type").text == "yellow" ? :yellow : :red)
        time = card.xpath("time").text.to_i
        
        team_data[:cards].concat([ { team: team, whoscored_id: whoscored_id, type: type, time: time } ])
      end

      team_data[:substitutions] = []
      team_xml.xpath("substitutions/substitution").each do |substitution|
        out_whoscored_id = substitution.xpath("playerOutWhoScoredId").text.to_i
        in_whoscored_id = substitution.xpath("playerInWhoScoredId").text.to_i
        time = substitution.xpath("time").text.to_i
        
        team_data[:substitutions].concat([ { team: team, out_whoscored_id: out_whoscored_id, in_whoscored_id: in_whoscored_id, time: time } ])
      end
      team_data
    end
    
    def validate_data(xml)
      data_errors = {}
      xml.remove_namespaces!
      
      home_team_xml = xml.xpath("//homeTeam")
      away_team_xml = xml.xpath("//awayTeam")
  
      home_team_validation_result = validate_team(home_team_xml)
      away_team_validation_result = validate_team(away_team_xml)
      
      # Check own goals.
      home_team_validation_result[:own_goal_players].each do |own_goal_player|        
        if !away_team_validation_result[:whoscored_ids].include?(own_goal_player[:whoscored_id])
          home_team_validation_result[:invalid_goal_players].concat [ own_goal_player ]              
        end
      end      
      away_team_validation_result[:own_goal_players].each do |own_goal_player|
        if !home_team_validation_result[:whoscored_ids].include?(own_goal_player[:whoscored_id])
          away_team_validation_result[:invalid_goal_players].concat [ own_goal_player ]              
        end
      end
      
      # Check that we're uploading the correct match.
      if !home_team_validation_result[:team].nil? && !away_team_validation_result[:team].nil?
        if @match.home_team != home_team_validation_result[:team] || @match.away_team != away_team_validation_result[:team]
          data_errors[:invalid_match] = { home_team: home_team_validation_result[:team], away_team: away_team_validation_result[:team] }
        end
      end

      if home_team_validation_result[:missing_teams].any? || away_team_validation_result[:missing_teams].any?
        data_errors[:missing_teams] = [].concat(home_team_validation_result[:missing_teams]).concat(away_team_validation_result[:missing_teams])
      end
      
      if home_team_validation_result[:missing_players].any? || away_team_validation_result[:missing_players].any?
        data_errors[:missing_players] = [].concat(home_team_validation_result[:missing_players]).concat(away_team_validation_result[:missing_players])
      end

      if home_team_validation_result[:missing_player_season_infos].any? || away_team_validation_result[:missing_player_season_infos].any?
        data_errors[:missing_player_season_infos] = [].concat(home_team_validation_result[:missing_player_season_infos]).concat(away_team_validation_result[:missing_player_season_infos])
      end

      if home_team_validation_result[:invalid_player_season_infos].any? || away_team_validation_result[:invalid_player_season_infos].any?
        data_errors[:invalid_player_season_infos] = [].concat(home_team_validation_result[:invalid_player_season_infos]).concat(away_team_validation_result[:invalid_player_season_infos])
      end
      
      if home_team_validation_result[:invalid_goal_players].any? || away_team_validation_result[:invalid_goal_players].any?
        data_errors[:invalid_goal_players] = [].concat(home_team_validation_result[:invalid_goal_players]).concat(away_team_validation_result[:invalid_goal_players])
      end

      if home_team_validation_result[:invalid_card_players].any? || away_team_validation_result[:invalid_card_players].any?
        data_errors[:invalid_card_players] = [].concat(home_team_validation_result[:invalid_card_players]).concat(away_team_validation_result[:invalid_card_players])
      end

      if home_team_validation_result[:invalid_substitution_players].any? || away_team_validation_result[:invalid_substitution_players].any?
        data_errors[:invalid_substitution_players] = [].concat(home_team_validation_result[:invalid_substitution_players]).concat(away_team_validation_result[:invalid_substitution_players])
      end
      
      data_errors
    end
  
    def validate_team(team_xml)
      team_validation_result = {}      
      team_validation_result[:missing_teams] = []
      team_validation_result[:missing_players] = []
      team_validation_result[:missing_player_season_infos] = []
      team_validation_result[:invalid_player_season_infos] = []
      team_validation_result[:invalid_goal_players] = []
      team_validation_result[:own_goal_players] = []
      team_validation_result[:invalid_card_players] = []
      team_validation_result[:invalid_substitution_players] = []      
      team_validation_result[:whoscored_ids] = []
      
      team_name = team_xml.xpath("name").text
      team = Team.where(name: team_name).take
      if team.nil?
        team_validation_result[:missing_teams].concat [ { team_name.to_sym => Team.named(team_name) } ]
      else
        team_validation_result[:team] = team
        # Check that all players:
        # a) Exist in the database with the given whoscored_id.
        # b) Have a PlayerSeasonInfo for the current season.
        # c) That the team in PlayerSeasonInfo is correct one.
        team_xml.xpath("players/playerMatchStatistics").each do |player_match_statistics|
          whoscored_id = player_match_statistics.xpath("whoScoredId").text
          player_name = player_match_statistics.xpath("player").text
          player = Player.where(whoscored_id: whoscored_id).take
          if player.nil?
            team_validation_result[:missing_players].concat [ { whoscored_id: whoscored_id, name: player_name, team: team, alternative_players: Player.named(player_name, :or) } ]
          else
            player_season_info = PlayerSeasonInfo.where(player: player, season: Season.current).take
            if player_season_info.nil?
              team_validation_result[:missing_player_season_infos].concat [ player ]              
            elsif player_season_info.team != team
              team_validation_result[:invalid_player_season_infos].concat [ player_season_info ]
            end
            team_validation_result[:whoscored_ids].concat [ whoscored_id ]            
          end
        end
        
        # Check that all non OG goals have a scorer that played for the current team.
        # Own goals will have to be checked later.
        team_xml.xpath("goals/goal").each do |goal|
          whoscored_id = goal.xpath("whoScoredId").text
          player_name = goal.xpath("player").text
          own_goal = goal.xpath("ownGoal").text == "true"
          if !own_goal
            if !team_validation_result[:whoscored_ids].include?(whoscored_id)
              team_validation_result[:invalid_goal_players].concat [ { whoscored_id: whoscored_id, name: player_name } ]              
            end
          else
            team_validation_result[:own_goal_players].concat [ { whoscored_id: whoscored_id, name: player_name } ]              
          end
        end
        
        # Check that all subs and cards have players that played for the current team.
        team_xml.xpath("cards/card").each do |card|
          whoscored_id = card.xpath("whoScoredId").text
          player_name = card.xpath("player").text
          if !team_validation_result[:whoscored_ids].include?(whoscored_id)
            team_validation_result[:invalid_card_players].concat [ { whoscored_id: whoscored_id, name: player_name } ]              
          end
        end

        team_xml.xpath("substitutions/substitution").each do |substitution|
          whoscored_id = substitution.xpath("playerOutWhoScoredId").text
          player_name = substitution.xpath("playerOut").text
          if !team_validation_result[:whoscored_ids].include?(whoscored_id)
            team_validation_result[:invalid_substitution_players].concat [ { whoscored_id: whoscored_id, name: player_name } ]              
          end
          
          whoscored_id = substitution.xpath("playerInWhoScoredId").text
          player_name = substitution.xpath("playerIn").text
          if !team_validation_result[:whoscored_ids].include?(whoscored_id)
            team_validation_result[:invalid_substitution_players].concat [ { whoscored_id: whoscored_id, name: player_name } ]              
          end        
        end      
      end      
      team_validation_result  
    end
end
