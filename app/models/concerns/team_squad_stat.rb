module TeamSquadStat
  extend ActiveSupport::Concern
  include PlayerStatsSummary

  included do
    belongs_to :team

    validates :team, presence: true

    def reset
      reset_stats_summary
    end       
  end
  
end
