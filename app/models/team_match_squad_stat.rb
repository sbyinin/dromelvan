class TeamMatchSquadStat < ActiveRecord::Base
  include TeamSquadStat
  
  belongs_to :match

  validates :match, presence: true

  def player_match_stats
    PlayerMatchStat.by_team(team).by_match(match)
  end

end
