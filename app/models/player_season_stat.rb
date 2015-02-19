class PlayerSeasonStat < ActiveRecord::Base
  include PlayerRanking
  
  belongs_to :season
  
  validates :season, presence: true

  def player_match_stats
    PlayerMatchStat.by_player(player).by_season(season)
  end
  
  def PlayerSeasonStat.update_rankings(season)
    ranking = 1
    PlayerSeasonStat.transaction do
      where(season: season).ranking_order.each do |player_season_stat|   
        # This is a LOT faster than updating and doing .save on each object
        PlayerSeasonStat.connection.execute "UPDATE player_season_stats SET ranking = #{ranking} WHERE id = #{player_season_stat.id}"
        ranking += 1
      end
    end
    ranking
  end
  
end
