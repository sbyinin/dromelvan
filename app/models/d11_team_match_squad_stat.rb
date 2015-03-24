class D11TeamMatchSquadStat < ActiveRecord::Base
  include D11TeamSquadStat
  
  belongs_to :d11_match

  validates :d11_match, presence: true

  def player_match_stats
    if !d11_match.nil?
      PlayerMatchStat.by_d11_team(d11_team).by_d11_match_day(d11_match.d11_match_day)
    else
      []
    end    
  end

  def players_not_played
    count = 0
    player_match_stats.each do |player_match_stat|
      if !player_match_stat.match.finished?
        count += 1
      end      
    end
    count
  end
  
  def players_played
    count = 0
    player_match_stats.each do |player_match_stat|
      if player_match_stat.match.finished?
        count += 1
      end      
    end    
    count    
  end
  
  def players_missing
    11 - player_match_stats.size
  end
  
end
