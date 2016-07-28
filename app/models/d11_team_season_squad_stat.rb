class D11TeamSeasonSquadStat < ActiveRecord::Base
  include D11TeamSquadStat
    
  belongs_to :season, touch: true

  validates :season, presence: true

  def player_match_stats    
    PlayerMatchStat.by_d11_team(d11_team).by_season(season)
  end
  
end
