module D11TeamSquadStat
  extend ActiveSupport::Concern
  include PlayerStatsSummary

  included do
    belongs_to :d11_team

    after_initialize :init
    before_validation :update_team_goals
  
    validates :d11_team, presence: true
    validates :team_goals, numericality: { greater_than_or_equal_to: 0 }
       
    def reset
      reset_stats_summary
      self.team_goals = 0
    end
    
    private
      def init
        self.team_goals ||= 0
      end
    
      def update_team_goals
        self.points ||= 0
        
        if self.points > 0 then
          self.team_goals = (points / 5) + 1
        else
          self.team_goals = 0
        end
      end       
  end
  
end
