class UploadMatchStatsFile < UploadXMLFile
  def initialize(match)
    @match = match 
  end
  
  private
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
            team_validation_result[:missing_players].concat [ { whoscored_id: whoscored_id, name: player_name, alternative_players: Player.named(player_name) } ]
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
