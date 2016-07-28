class TeamSeasonSquadStat < ActiveRecord::Base
  include TeamSquadStat
  
  belongs_to :season, touch: true

  validates :season, presence: true

  def player_match_stats
    PlayerMatchStat.by_team(team).by_season(season)
  end
  
end
