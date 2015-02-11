class D11MatchPreview
  include Preview
  
  attr_accessor :d11_match 
 
  def initialize(parameters)
    @d11_match = parameters[:d11_match]
    @previous_meetings = D11Match.where('(home_d11_team_id = ? and away_d11_team_id = ?) or (home_d11_team_id = ? and away_d11_team_id = ?)',
                                         @d11_match.home_d11_team_id, @d11_match.away_d11_team_id, @d11_match.away_d11_team_id, @d11_match.home_d11_team_id).where(status: 2).reverse_order
    @previous_meetings_count = @previous_meetings.size
    
    initialize_preview
    
    @previous_meetings.each do |previous_meeting_d11_match|
      if previous_meeting_d11_match.points(@d11_match.home_d11_team) == 3
        @home_wins += 1
      elsif previous_meeting_d11_match.points(@d11_match.away_d11_team) == 3
        @away_wins += 1
      else
        @draws += 1
      end

      @home_goals += previous_meeting_d11_match.goals_for(@d11_match.home_d11_team)
      @away_goals += previous_meeting_d11_match.goals_for(@d11_match.away_d11_team)

      PlayerMatchStat.by_d11_match_day(previous_meeting_d11_match.d11_match_day).each do |player_match_stat|      
        if player_match_stat.yellow_card_time > 0
          if player_match_stat.d11_team == @d11_match.home_d11_team
            @home_yellow_cards += 1
          else
            @away_yellow_cards += 1
          end
        end
        if player_match_stat.red_card_time > 0
          if player_match_stat.d11_team == @d11_match.home_d11_team
            @home_red_cards += 1
          else
            @away_red_cards += 1
          end          
        end
      end  
    end
    
    if @previous_meetings_count > 0
      @home_win_percentage = ((@home_wins.to_f / @previous_meetings_count.to_f) * 100).to_i
      @draw_percentage = ((@draws.to_f / @previous_meetings_count.to_f) * 100).to_i
      @away_win_percentage = ((@away_wins.to_f / @previous_meetings_count.to_f) * 100).to_i
    end
  end
  
end
