class TransferListing < ActiveRecord::Base
  include PlayerStatsSummary
  
  belongs_to :transfer_day
  belongs_to :player
  belongs_to :team
  belongs_to :d11_team
  belongs_to :position
  
  default_scope -> { order(points: :desc) }
  
  validates :transfer_day, presence: true
  validates :player, presence: true
  validates :team, presence: true
  validates :d11_team, presence: true
  validates :position, presence: true
  validates :ranking, numericality: { greater_than_or_equal_to: 0 }
  validates :new_player, inclusion: [true, false]
  
  def player_match_stats
    player_match_stats = []
    if !transfer_day.nil? then
      player_match_stats = PlayerMatchStat.by_player_and_season(player, transfer_day.transfer_window.season)
      player_match_stats.each do |player_match_stat|
        # puts("kek")
      end
    end
    player_match_stats
  end

  def reset
    reset_stats_summary
    self.ranking = 0
  end
  
end
