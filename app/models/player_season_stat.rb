class PlayerSeasonStat < ActiveRecord::Base
  #include PlayerStats, PlayerStatsSummary
  include PlayerStatsSummary
  
  belongs_to :player
  belongs_to :season
  
  after_initialize :init
  
  validates :player, presence: true
  validates :season, presence: true
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
