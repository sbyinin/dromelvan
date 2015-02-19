class TeamCareerSquadStat < ActiveRecord::Base
  include TeamSquadStat
  
  def player_match_stats
    PlayerMatchStat.by_team(team)
  end
  
end
