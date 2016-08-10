class PlayerCareerStat < ActiveRecord::Base
  include PlayerRanking

  after_initialize :init_career_stats
  before_validation :summarize_career_stats

  validates :seasons, numericality: { greater_than_or_equal_to: 0 }
  validates :points_per_season, presence: true, numericality: { only_integer: true }

  def player_match_stats
    PlayerMatchStat.by_player(player)
  end

  def points_per_season_s
    '%.2f' % (points_per_season.to_f / 100)
  end

  def PlayerCareerStat.by_player(player)
    player_career_stat = where(player: player).first
    player_career_stat
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
  
  def summarize_career_stats
    reset_career_stats
    PlayerSeasonStat.where(player: player).each do |player_season_stat|
      self.seasons += 1
      self.points_per_season += player_season_stat.points
    end
    if self.seasons > 0 then
      self.points_per_season = ((self.points_per_season.to_f / self.seasons.to_f).round(2) * 100).to_i
    end
  end
  
  def reset_career_stats
    self.seasons = 0
    self.points_per_season = 0
  end
  
  private
    def init_career_stats
      self.seasons ||= 0
      self.points_per_season ||= 0
    end
      
end
