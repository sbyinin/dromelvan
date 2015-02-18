class D11TeamMatchSquadStat < ActiveRecord::Base
  include PlayerStatsSummary
  
  belongs_to :d11_team
  belongs_to :d11_match

  after_initialize :init
  
  validates :d11_team, presence: true
  validates :d11_match, presence: true
  validates :team_goals, numericality: { greater_than_or_equal_to: 0 }

  def player_match_stats
    if !d11_match.nil?
      PlayerMatchStat.by_d11_team(d11_team).by_d11_match_day(d11_match.d11_match_day)
    else
      []
    end    
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
