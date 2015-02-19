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
  
end
