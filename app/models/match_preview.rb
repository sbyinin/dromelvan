class MatchPreview
  include Preview
  
  attr_accessor :match 
 
  def initialize(parameters)
    @match = parameters[:match]
    @previous_meetings = Match.where('(home_team_id = ? and away_team_id = ?) or (home_team_id = ? and away_team_id = ?)', @match.home_team_id, @match.away_team_id, @match.away_team_id, @match.home_team_id).where(status: 2).reorder(datetime: :desc)
    @previous_meetings_count = @previous_meetings.size
    
    initialize_preview
    
    @previous_meetings.each do |previous_meeting_match|
      if previous_meeting_match.points(@match.home_team) == 3
        @home_wins += 1
      elsif previous_meeting_match.points(@match.away_team) == 3
        @away_wins += 1
      else
        @draws += 1
      end
      @home_goals += previous_meeting_match.goals_for(@match.home_team)
      @away_goals += previous_meeting_match.goals_for(@match.away_team)
      
      @home_yellow_cards += previous_meeting_match.cards.where(team: @match.home_team, card_type: 0).size
      @home_red_cards += previous_meeting_match.cards.where(team: @match.home_team, card_type: 1).size
      @away_yellow_cards += previous_meeting_match.cards.where(team: @match.away_team, card_type: 0).size
      @away_red_cards += previous_meeting_match.cards.where(team: @match.away_team, card_type: 1).size      
    end
    
    if @previous_meetings_count > 0
      @home_win_percentage = ((@home_wins.to_f / @previous_meetings_count.to_f) * 100).to_i
      @draw_percentage = ((@draws.to_f / @previous_meetings_count.to_f) * 100).to_i
      @away_win_percentage = ((@away_wins.to_f / @previous_meetings_count.to_f) * 100).to_i
    end
    
  end  
end
