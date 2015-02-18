class D11TeamSeasonSquadStat < ActiveRecord::Base
  include PlayerStatsSummary
  
  belongs_to :d11_team
  belongs_to :season

  after_initialize :init
  
  validates :d11_team, presence: true
  validates :season, presence: true
  validates :team_goals, numericality: { greater_than_or_equal_to: 0 }

  def player_match_stats    
    PlayerMatchStat.by_d11_team(d11_team).by_season(season)
  end
  
  def reset
    reset_stats_summary
    self.team_goals = 0
  end

  private
  
    def init
      self.team_goals ||= 0
    end
  
end
