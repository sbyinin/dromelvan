class TeamSeasonSquadStat < ActiveRecord::Base
  include PlayerStatsSummary
  
  belongs_to :team
  belongs_to :season

  validates :team, presence: true
  validates :season, presence: true

  def player_match_stats
    PlayerMatchStat.by_team(team).by_season(season)
  end
  
  def reset
    reset_stats_summary
  end
  
end
