class PlayerCareerStat < ActiveRecord::Base
  include PlayerRanking
    
  def player_match_stats
    PlayerMatchStat.by_player(player)
  end
  
  def PlayerCareerStat.update_rankings
    ranking = 1
    PlayerCareerStat.transaction do
      ranking_order.each do |player_career_stat|   
        # This is a LOT faster than updating and doing .save on each object
        PlayerCareerStat.connection.execute "UPDATE player_career_stats SET ranking = #{ranking} WHERE id = #{player_career_stat.id}"
        ranking += 1
      end
    end
    ranking
  end
  
end
