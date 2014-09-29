class PlayerSeasonStat < ActiveRecord::Base
  include PlayerStatsSummary
  
  belongs_to :player
  belongs_to :season
  
  after_initialize :init
  
  validates :player, presence: true
  validates :season, presence: true
  validates :ranking, numericality: { greater_than_or_equal_to: 0 }

  def player_match_stats
    PlayerMatchStat.by_player_and_season(player, season)
  end
  
  def reset
    reset_stats_summary
    self.ranking = 0
  end

  def PlayerSeasonStat.update_rankings(season)
    ranking = 1
    PlayerSeasonStat.transaction do
      where(season: season).order(points: :desc).each do |player_season_stat|
        # This is a LOT faster than updating and doing .save on each object
        PlayerSeasonStat.connection.execute "UPDATE player_season_stats SET ranking = #{ranking} WHERE id = #{player_season_stat.id}"
        ranking += 1
      end
    end
    ranking
  end
  
  private
  
    def init
      self.ranking ||= 0
    end
end
