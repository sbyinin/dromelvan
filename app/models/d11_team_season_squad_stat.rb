class D11TeamSeasonSquadStat < ActiveRecord::Base
  include D11TeamSquadStat
    
  belongs_to :season, touch: true

  validates :season, presence: true

  def value
    PlayerSeasonInfo.where(d11_team: d11_team).where(season: season).pluck(:value).sum
  end
 
  def max_bid
    player_count = PlayerSeasonInfo.where(d11_team: d11_team).where(season: season).size
    if player_count < 11 then
      reserved = 5 * (11 - player_count)
      max_bid = 500 - value - reserved + 5
      max_bid
    else
      0
    end    
  end
  
  def player_match_stats    
    PlayerMatchStat.by_d11_team(d11_team).by_season(season)
  end
  
end
