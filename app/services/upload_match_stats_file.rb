class UploadMatchStatsFile < UploadXMLFile
  def initialize(match)
    @match = match 
  end
  
  private
    def validate_data(xml)
      data_errors = []
      missing_players = []
      
      xml.remove_namespaces!
  
      # Check that we have the right match.
      match_whoscored_id = xml.xpath("/match/whoScoredId").text.to_i
      if @match.whoscored_id != match_whoscored_id
        data_errors.concat [ "Invalid match. The selected match has whoscored_id #{@match.whoscored_id} but the uploaded file contains data for match #{match_whoscored_id}." ]        
      end
      
      # Check that the match has the right teams.
      home_team_whoscored_id = xml.xpath("/match/teams/homeTeam/whoScoredId").text.to_i
      if @match.home_team.whoscored_id != home_team_whoscored_id
        data_errors.concat [ "Invalid team. The match home team has whoscored_id #{@match.home_team.whoscored_id} but the uploaded file contains home team whoscored_id #{home_team_whoscored_id}." ]        
      end
      away_team_whoscored_id = xml.xpath("/match/teams/awayTeam/whoScoredId").text.to_i
      if @match.away_team.whoscored_id != away_team_whoscored_id
        data_errors.concat [ "Invalid team. The match away team has whoscored_id #{@match.away_team.whoscored_id} but the uploaded file contains away team whoscored_id #{away_team_whoscored_id}." ]        
      end
      
      # Check that all the players exist.
      player_match_stats = {}
      xml.xpath("/match/playerMatchStats/playerMatchStat").each do |player_match_stat|
        player_whoscored_id = player_match_stat.xpath("player/whoScoredId").text.to_i
        player_match_stats[player_whoscored_id] = player_match_stat
        player = Player.where(whoscored_id: player_whoscored_id).first
        if player.nil?
          # If there's a player with the same parameterized name in the same team we're going to
          # change that players whoscored_id when we insert the data so we won't bother marking him as missing.
          player_name = player_match_stat.xpath("player/name").text
          team_whoscored_id = player_match_stat.xpath("team/whoScoredId").text.to_i
          position_id = player_match_stat.xpath("position").text.to_i
          team_id = (@match.home_team.whoscored_id == team_whoscored_id ? @match.home_team_id : @match.away_team_id)
          if !Player.joins(player_season_infos: :team).where(player_season_infos: { season_id: Season.current.id }, teams: {whoscored_id: team_whoscored_id}, parameterized_name: player_name.parameterize).any?
              team_name = player_match_stat.xpath("team/name").text              
              missing_players.concat [ { player_whoscored_id: player_whoscored_id, player_name: player_name, team_id: team_id, team_name: team_name, position_id: position_id, alternative_players: Player.named(player_name, :or) } ]
          end          
        end
      end
      
      # The checks below are probably unnecessary as they most likely will never happen but just in case...
      # Check that all match events have players and teams that take part in the match.
      xml.xpath("/match/goals/goal | /match/cards/card | /match/substitutions/substitution").each do |match_event|
        match_event.xpath("player | playerOn | playerOff").each do |player|
          player_whoscored_id = player.xpath("whoScoredId").text.to_i
          player_name = player.xpath("name").text
          if player_match_stats[player_whoscored_id].nil?
            data_errors.concat ["Invalid #{match_event.name}. Player #{player_name} (#{player_whoscored_id}) is referenced in a #{match_event.name} event but is not listed in any of the team squads."]
          end          
        end
        team_whoscored_id = match_event.xpath("team/whoScoredId").text.to_i
        team_name = match_event.xpath("team/name").text
        if @match.home_team.whoscored_id != team_whoscored_id && @match.away_team.whoscored_id != team_whoscored_id
          data_errors.concat ["Invalid #{match_event.name}. Team #{team_name} (#{team_whoscored_id}) is referenced in a #{match_event.name} event but is not one of the teams playing this match."]
        end
      end

      # Check that own goals and penalties have the right teams and make sense.
      xml.xpath("/match/goals/goal").each do |goal|
        if goal.xpath("ownGoal").text == "true"        
          player_whoscored_id = goal.xpath("player/whoScoredId").text.to_i        
          player_match_stat = player_match_stats[player_whoscored_id]
          if !player_match_stat.nil? && player_match_stat.xpath("team/whoScoredId").text == goal.xpath("team/whoScoredId").text
            data_errors.concat ["Invalid own goal. Player #{goal.xpath("player/name").text} (#{player_whoscored_id}) is registered as having scored an own goal for his own team in this match."]
          end
          if goal.xpath("penalty").text == "true"
            data_errors.concat ["Invalid own goal. Player #{goal.xpath("player/name").text} (#{player_whoscored_id}) is registered as having scored a penalty own goal."]
          end
        end        
      end
      
      return data_errors, missing_players
    end
  
    def update_data(xml)
      data_updates = []
      Match.transaction do
        player_match_stats = {}
        @match.player_match_stats.each do |player_match_stat|
          player_match_stat.reset
          player_match_stats[player_match_stat.player.whoscored_id] = player_match_stat
        end
        @match.goals.delete_all
        @match.cards.delete_all
        @match.substitutions.delete_all
        @match.status = :active
        season = @match.match_day.premier_league.season
        
        xml.xpath("/match/playerMatchStats/playerMatchStat").each do |player_match_stat_xml|
          whoscored_id = player_match_stat_xml.xpath("player/whoScoredId").text.to_i          
          player = Player.where(whoscored_id: whoscored_id).take
          team = Team.where(whoscored_id: player_match_stat_xml.xpath("team/whoScoredId").text.to_i).take

          # If we can't find a player with a given whoscored_id, find the one with the same name in the same team and change his whoscored_id.
          # If there is no such player then the validation will have failed before we get here.
          if player.nil?            
            player = Player.joins(player_season_infos: :team).where(player_season_infos: { season_id: Season.current.id }, teams: {whoscored_id: team.whoscored_id}, parameterized_name: player_match_stat_xml.xpath("player/name").text.parameterize).take
            old_whoscored_id = player.whoscored_id
            player.whoscored_id = whoscored_id
            player.save
            data_updates.concat([ "Changed whoscored id for player #{player.name} from #{old_whoscored_id} to #{player.whoscored_id}." ])
            player_match_stats[player.whoscored_id] = player_match_stats[old_whoscored_id]
            player_match_stats.delete(old_whoscored_id)            
          end
          
          player_season_info = player.season_info(season)
          
          # Add or move players who aren't registered for this season or who are registered for another team than
          # the team the match file says theplayer is playing for in this match.
          if player_season_info.nil?            
            previous_player_season_info = player.player_season_infos.first
            position = (!previous_player_season_info.nil? ? previous_player_season_info.position : Position.find(6))
            player_season_info = PlayerSeasonInfo.create(player: player, season: season, team: team, position: position)
            PlayerSeasonStat.create(player: player, season: season)
            data_updates.concat([ "Added player #{player.name} (#{player.whoscored_id}) to team #{team.name}." ])
          elsif player_season_info.team != team
            old_team = player_season_info.team
            player_season_info.team = team
            player_season_info.save

            # Remove existing player_match_stats for this match day so the player doesn't end up playing two matches for the same D11 team
            # the same match day. NOTE: This means we have to change things manually before uploading postponed matches to avoid screwing things up.
            PlayerMatchStat.joins(:match).where(matches: { match_day_id: @match.match_day_id }, player_id: player.id).each do |player_match_stat|
              if player_match_stat.match != @match
                player_match_stat.delete
              end
            end
            data_updates.concat([ "Moved player #{player.name} (D11 Team: #{player_season_info.d11_team.name}, whoscored_id: #{player.whoscored_id}) from team #{old_team.name} to team #{team.name}." ])
          end
          
          # Create player_match_stat for players who've been added to the match teams after the match day was activated.
          player_match_stat = player_match_stats[whoscored_id]
          if player_match_stat.nil?
            player_match_stat = PlayerMatchStat.create(match: @match, player: player, team: team, d11_team: player_season_info.d11_team, position: player_season_info.position)
            player_match_stats[whoscored_id] = player_match_stat
          end
          
          # Update and save stats.
          player_match_stat.played_position = player_match_stat_xml.xpath("playedPosition").text
          player_match_stat.lineup = player_match_stat_xml.xpath("lineup").text.to_i
          player_match_stat.substitution_on_time = player_match_stat_xml.xpath("substitutionOnTime").text.to_i
          player_match_stat.substitution_off_time = player_match_stat_xml.xpath("substitutionOffTime").text.to_i
          player_match_stat.goals = player_match_stat_xml.xpath("goalsScored").text.to_i          
          player_match_stat.goal_assists = player_match_stat_xml.xpath("goalAssists").text.to_i
          player_match_stat.own_goals = player_match_stat_xml.xpath("ownGoals").text.to_i                              
          if player_match_stat.position.defender?
            player_match_stat.goals_conceded = player_match_stat_xml.xpath("goalsConceded").text.to_i                              
          end
          player_match_stat.yellow_card_time = player_match_stat_xml.xpath("yellowCardTime").text.to_i
          player_match_stat.red_card_time = player_match_stat_xml.xpath("redCardTime").text.to_i                              
          player_match_stat.man_of_the_match = player_match_stat_xml.xpath("manOfTheMatch").text == "true"
          player_match_stat.shared_man_of_the_match = player_match_stat_xml.xpath("sharedManOfTheMatch").text == "true"
          player_match_stat.rating = player_match_stat_xml.xpath("rating").text.to_i                              
          
          player_match_stat.save
          PlayerSeasonStat.where(player: player, season: season).take.save
          PlayerCareerStat.where(player: player).take.save          
        end
        
        xml.xpath("/match/goals/goal").each do |goal|
          player = Player.where(whoscored_id: goal.xpath("player/whoScoredId").text.to_i).first
          team = Team.where(whoscored_id: goal.xpath("team/whoScoredId").text.to_i).first
          time = goal.xpath("time").text.to_i
          penalty = goal.xpath("penalty").text == "true"
          own_goal = goal.xpath("ownGoal").text == "true"
          Goal.create(match: @match, player: player, team: team, time: time, penalty: penalty, own_goal: own_goal)          
        end

        xml.xpath("/match/cards/card").each do |card|
          player = Player.where(whoscored_id: card.xpath("player/whoScoredId").text.to_i).first
          team = Team.where(whoscored_id: card.xpath("team/whoScoredId").text.to_i).first
          time = card.xpath("time").text.to_i
          card_type = (card.xpath("cardType").text == "yellow" ? :yellow : :red)
          Card.create(match: @match, player: player, team: team, time: time, card_type: card_type)          
        end

        xml.xpath("/match/substitutions/substitution").each do |substitution|
          player_on = Player.where(whoscored_id: substitution.xpath("playerOn/whoScoredId").text.to_i).first
          player_off = Player.where(whoscored_id: substitution.xpath("playerOff/whoScoredId").text.to_i).first
          team = Team.where(whoscored_id: substitution.xpath("team/whoScoredId").text.to_i).first
          time = substitution.xpath("time").text.to_i
          Substitution.create(match: @match, player: player_off, player_in: player_on, team: team, time: time)          
        end
        
        @match.status = :finished
        @match.save

        PlayerSeasonStat.update_rankings(season)
        PlayerCareerStat.update_rankings                    
                        
        @match.team_match_squad_stats.each do |team_match_squad_stat|
          team_match_squad_stat.save
        end
        
        @match.match_day.d11_match_day.d11_matches.each do |d11_match|
          d11_match.d11_team_match_squad_stats.each do |d11_team_match_squad_stat|
            d11_team_match_squad_stat.save
          end
          d11_match.save
        end        
      end
      data_updates
    end
  
end
