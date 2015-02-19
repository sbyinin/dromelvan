class D11TeamCareerSquadStat < ActiveRecord::Base
  include D11TeamSquadStat
  
  def player_match_stats    
    PlayerMatchStat.by_d11_team(d11_team)
  end
    
end
