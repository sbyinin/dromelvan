class TransferListing < ActiveRecord::Base
  include PlayerStatsSummary
  
  belongs_to :transfer_day, touch: true
  belongs_to :player
  belongs_to :team
  belongs_to :d11_team
  belongs_to :position
  
  # Todo - do this with symbols instead of a string
  default_scope -> { joins(:d11_team).order("d11_teams.name, points desc") }
  
  after_initialize :init
  
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
      PlayerMatchStat.by_player(player).by_season(transfer_day.transfer_window.season).each do |player_match_stat|
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

  def TransferListing.create_for(transfer_day, include_owned = false)
    PlayerSeasonStat.where(season: transfer_day.transfer_window.season).each do |player_season_stat|
      player_season_info = PlayerSeasonInfo.current(player_season_stat.player)
      if include_owned || player_season_info.d11_team.dummy?
        transfer_listing = TransferListing.new(transfer_day: transfer_day)
        transfer_listing.player = player_season_stat.player
        transfer_listing.team = player_season_info.team
        transfer_listing.position = player_season_info.position
        transfer_listing.goals = player_season_stat.goals
        transfer_listing.goal_assists = player_season_stat.goal_assists
        transfer_listing.own_goals = player_season_stat.own_goals
        transfer_listing.goals_conceded = player_season_stat.goals_conceded
        transfer_listing.clean_sheets = player_season_stat.clean_sheets
        transfer_listing.yellow_cards = player_season_stat.yellow_cards
        transfer_listing.red_cards = player_season_stat.red_cards
        transfer_listing.man_of_the_match = player_season_stat.man_of_the_match
        transfer_listing.shared_man_of_the_match = player_season_stat.shared_man_of_the_match
        transfer_listing.rating = player_season_stat.rating
        transfer_listing.points = player_season_stat.points
        transfer_listing.games_started = player_season_stat.games_started
        transfer_listing.games_substitute = player_season_stat.games_substitute
        transfer_listing.games_did_not_participate = player_season_stat.games_did_not_participate
        transfer_listing.substitutions_on = player_season_stat.substitutions_on
        transfer_listing.substitutions_off = player_season_stat.substitutions_off
        transfer_listing.minutes_played = player_season_stat.minutes_played
        transfer_listing.ranking = player_season_stat.ranking
        transfer_listing.new_player = false #TODO Fix this.
        transfer_listing.d11_team = D11Team.find(1)
        transfer_listing.points_per_appearance = player_season_stat.points_per_appearance
        transfer_listing.save
      end
    end
  end
  
  def TransferListing.update_rankings(transfer_day)
    ranking = 1
    TransferListing.transaction do
      where(transfer_day: transfer_day).reorder(points: :desc).each do |transfer_listing|   
        # This is a LOT faster than updating and doing .save on each object
        TransferListing.connection.execute "UPDATE transfer_listings SET ranking = #{ranking} WHERE id = #{transfer_listing.id}"
        ranking += 1
      end
    end
    ranking
  end
  
  private
  
    def init
      self.position_id ||= 6
      self.ranking ||= 0
      self.team_id ||= 1
    end
  
end
