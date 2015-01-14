class TransferListing < ActiveRecord::Base
  include PlayerStatsSummary
  
  belongs_to :transfer_day
  belongs_to :player
  belongs_to :team
  belongs_to :d11_team
  belongs_to :position
  
  # Todo - do this with symbols instead of a string
  default_scope -> { joins(:d11_team).order("d11_teams.name, points desc") }
  
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
      PlayerMatchStat.by_player_and_season(player, transfer_day.transfer_window.season).each do |player_match_stat|
        if player_match_stat.match.datetime <= transfer_day.datetime
          player_match_stats << player_match_stat
        end
      end
    end
    player_match_stats
  end

  def reset
    reset_stats_summary
    self.ranking = 0
  end
  
end
