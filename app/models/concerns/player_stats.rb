module PlayerStats
  extend ActiveSupport::Concern

  included do
    after_initialize :init_stats

    validates :goals, numericality: { greater_than_or_equal_to: 0 }
    validates :goal_assists, numericality: { greater_than_or_equal_to: 0 }
    validates :own_goals, numericality: { greater_than_or_equal_to: 0 }
    validates :goals_conceded, numericality: { greater_than_or_equal_to: 0 }
    validates :rating, inclusion: 0..1000
    validates :points, presence: true, numericality: { only_integer: true }
    
    def rating_s
      '%.2f' % (rating.to_f / 100)
    end
    
    private
      def reset_stats
        self.goals = 0
        self.goal_assists = 0
        self.own_goals = 0
        self.goals_conceded = 0
        self.rating = 0
        self.points = 0              
      end      
    
      def init_stats
        self.goals ||= 0
        self.goal_assists ||= 0
        self.own_goals ||= 0
        self.goals_conceded ||= 0
        self.rating ||= 0
        self.points ||= 0              
      end      
  end
  
end