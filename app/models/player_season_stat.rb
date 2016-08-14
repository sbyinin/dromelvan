class PlayerSeasonStat < ActiveRecord::Base
  include PlayerRanking
  
  belongs_to :season, touch: true
  
  scope :by_player_season_infos, -> { joins("JOIN player_season_infos ON player_season_stats.player_id = player_season_infos.player_id AND player_season_stats.season_id = player_season_infos.season_id") }
  scope :position_order, -> { by_player_season_infos.joins("JOIN positions ON player_season_infos.position_id = positions.id").order("positions.sort_order").ranking_order }
 
  after_initialize :init_form_points
  before_validation :summarize_form_points
  after_create :do_after_create
  
  validates :season, presence: true
  validates :form_points, presence: true, numericality: { only_integer: true }


  def player_match_stats
    PlayerMatchStat.by_player(player).by_season(season)
  end

  def PlayerSeasonStat.by_team(team)
    position_order.where(player_season_infos: { team_id: team.id })
  end
  
  def PlayerSeasonStat.by_d11_team(d11_team)
    position_order.where(player_season_infos: { d11_team_id: d11_team.id })
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
  
  def summarize_form_points
    reset_form_points
    if !player.nil? then
      player.form_player_match_stats(season).each do |player_match_stat|
        self.form_points += player_match_stat.points
      end
    end    
  end
  
  private  
    def reset_form_points
        self.form_points = 0
    end    
  
    def init_form_points
      self.form_points ||= 0
    end
    
    def do_after_create
      PlayerSeasonStat.update_rankings(self.season)
    end
end
