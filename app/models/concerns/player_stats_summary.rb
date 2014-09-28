module PlayerStatsSummary
  extend ActiveSupport::Concern
  include PlayerStats

  included do
    after_initialize :init_stats_summary

    validates :clean_sheets, numericality: { greater_than_or_equal_to: 0 }
    validates :yellow_cards, numericality: { greater_than_or_equal_to: 0 }
    validates :red_cards, numericality: { greater_than_or_equal_to: 0 }
    validates :man_of_the_match, numericality: { greater_than_or_equal_to: 0 }
    validates :shared_man_of_the_match, numericality: { greater_than_or_equal_to: 0 }
    validates :games_started, numericality: { greater_than_or_equal_to: 0 }
    validates :games_substitute, numericality: { greater_than_or_equal_to: 0 }
    validates :games_did_not_participate, numericality: { greater_than_or_equal_to: 0 }
    validates :substitutions_on, numericality: { greater_than_or_equal_to: 0 }
    validates :substitutions_off, numericality: { greater_than_or_equal_to: 0 }
    validates :minutes_played, numericality: { greater_than_or_equal_to: 0 }    
    
    def reset_stats_summary
        self.goals = 0
        self.goal_assists = 0
        self.own_goals = 0
        self.goals_conceded = 0
        self.rating = 0
        self.points = 0                    
        self.clean_sheets = 0
        self.yellow_cards = 0
        self.red_cards = 0
        self.man_of_the_match = 0
        self.shared_man_of_the_match = 0
        self.games_started = 0
        self.games_substitute = 0
        self.games_did_not_participate = 0
        self.substitutions_on = 0
        self.substitutions_off = 0
        self.minutes_played = 0              
    end
    
    private
      def init_stats_summary
        self.clean_sheets ||= 0
        self.yellow_cards ||= 0
        self.red_cards ||= 0
        self.man_of_the_match ||= 0
        self.shared_man_of_the_match ||= 0
        self.games_started ||= 0
        self.games_substitute ||= 0
        self.games_did_not_participate ||= 0
        self.substitutions_on ||= 0
        self.substitutions_off ||= 0
        self.minutes_played ||= 0        
      end      
  end
  
end
