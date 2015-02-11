module Preview
  extend ActiveSupport::Concern 

  included do
    attr_accessor :previous_meetings
    attr_accessor :previous_meetings_count
    attr_accessor :home_wins
    attr_accessor :draws
    attr_accessor :away_wins
    attr_accessor :home_goals
    attr_accessor :away_goals
    attr_accessor :home_win_percentage
    attr_accessor :draw_percentage
    attr_accessor :away_win_percentage
    attr_accessor :home_yellow_cards
    attr_accessor :home_red_cards
    attr_accessor :away_yellow_cards
    attr_accessor :away_red_cards
    
    def initialize_preview
      @home_wins = 0
      @draws = 0
      @away_wins = 0
  
      @home_goals = 0
      @away_goals = 0
      
      @home_yellow_cards = 0
      @home_red_cards = 0
      @away_yellow_cards = 0
      @away_red_cards = 0
  
      @home_win_percentage = 0
      @draw_percentage = 0
      @away_win_percentage = 0      
    end
  end
end