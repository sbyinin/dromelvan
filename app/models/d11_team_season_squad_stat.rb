class D11TeamSeasonSquadStat < ActiveRecord::Base
  include D11TeamSquadStat
    
  belongs_to :season

  validates :season, presence: true

  def player_match_stats    
    PlayerMatchStat.by_d11_team(d11_team).by_season(season)
  end
  
end
