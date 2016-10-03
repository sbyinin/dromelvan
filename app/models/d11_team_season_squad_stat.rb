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

  def position_available(position)
    count = PlayerSeasonInfo.where(d11_team: d11_team).where(season: season).where(position: position).size
    if position.id == 1
      return count < 1
    elsif position.id == 2 || position.id == 3
      return count < 4
    elsif position.id == 5
      return count < 2
    end
    return false
  end

  def position_available_count(position)
    count = PlayerSeasonInfo.where(d11_team: d11_team).where(season: season).where(position: position).size
    if position.id == 1
      return 1 - count
    elsif position.id == 2 || position.id == 3
      return 4 - count
    elsif position.id == 5
      return 2 - count
    end
    return 0
  end
  
  def player_match_stats    
    PlayerMatchStat.by_d11_team(d11_team).by_season(season)
  end
  
end
