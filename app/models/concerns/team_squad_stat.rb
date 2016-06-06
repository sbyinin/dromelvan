module TeamSquadStat
  extend ActiveSupport::Concern
  include PlayerStatsSummary

  included do
    belongs_to :team

    before_validation :update_team_goals
    
    validates :team, presence: true

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
