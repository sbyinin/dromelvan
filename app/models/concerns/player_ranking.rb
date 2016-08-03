module PlayerRanking
  extend ActiveSupport::Concern
  include PlayerStatsSummary

  included do
    belongs_to :player
    # TODO: Do this with symbols
    scope :ranking_order, -> { joins(:player).order("points desc, goals desc, man_of_the_match desc, goal_assists desc,
                                                     shared_man_of_the_match desc, rating desc, red_cards asc, yellow_cards asc,
                                                     last_name asc, first_name asc") }

    after_initialize :init
    
    validates :player, presence: true
    validates :ranking, numericality: { greater_than_or_equal_to: 0 }
       
    def reset
      reset_stats_summary
      self.ranking = 0
    end
        
    private
      def init
        self.ranking ||= 0
      end
    
  end
  
end
