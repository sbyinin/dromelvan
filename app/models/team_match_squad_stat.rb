class TeamMatchSquadStat < ActiveRecord::Base
  include PlayerStatsSummary
  
  belongs_to :team
  belongs_to :match

  validates :team, presence: true
  validates :match, presence: true

  def player_match_stats
    PlayerMatchStat.by_team(team).by_match(match)
  end

  def reset
    reset_stats_summary
  end

end
