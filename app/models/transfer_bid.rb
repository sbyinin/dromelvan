class TransferBid < ActiveRecord::Base

  belongs_to :transfer_day, touch: true
  belongs_to :player
  belongs_to :d11_team

  default_scope -> { order(:player_ranking, active_fee: :desc, d11_team_ranking: :desc) }

  after_initialize :init
  
  validates :transfer_day, presence: true
  validates :player, presence: true
  validates :player_ranking, numericality: { greater_than_or_equal_to: 0 }
  validates :d11_team, presence: true
  validates :d11_team_ranking, numericality: { greater_than_or_equal_to: 0 }
  validates :fee, presence: true
  validates :active_fee, presence: true
  validates :successful, inclusion: [true, false]
  validate  :validate_fees

  # Use only for inserting dummy bids for preseason transfer day.  
  def TransferBid.create_for(transfer_day)
    PlayerSeasonInfo.joins(:d11_team).where(season: transfer_day.transfer_window.season, d11_teams: {dummy: false}).each do |player_season_info|
      player_season_stat = PlayerSeasonStat.where(season: transfer_day.transfer_window.season, player: player_season_info.player).take
      d11_team_table_stat = D11TeamTableStat.where(d11_match_day: transfer_day.transfer_window.d11_match_day, d11_team: player_season_info.d11_team).take

      transfer_bid = TransferBid.new(transfer_day: transfer_day)
      transfer_bid.player = player_season_info.player
      transfer_bid.player_ranking = player_season_stat.ranking
      transfer_bid.d11_team = player_season_info.d11_team
      transfer_bid.d11_team_ranking = d11_team_table_stat.ranking
      transfer_bid.fee = player_season_info.value
      transfer_bid.active_fee = player_season_info.value
      transfer_bid.successful = true
      transfer_bid.save          
    end
  end
  
  private
    def init
      self.player_ranking ||= 0
      self.d11_team_ranking ||= 0
      self.successful ||= false
    end
  
    def validate_fees
      # We'll do it like this with the greater than as well as the modulo since
      # we want to be able to seed bids for legacy seasons.
      if !transfer_day.nil? && transfer_day.transfer_window.season.legacy? then        
        if !fee.nil? && fee < 0 then
          errors.add(:fee, "must be greater than or equal to 0.0")
        end          

        if !active_fee.nil? && active_fee < 0 then
          errors.add(:active_fee, "must be greater than or equal to 0.0")
        end                  
      else
        if !fee.nil?
          if fee < 5 then
            errors.add(:fee, "must be greater than or equal to 0.5")
          end

          if !fee.modulo(5).zero? then
            errors.add(:fee, "must be divisible by 0.5")
          end          
        end        

        if !active_fee.nil? then
          if active_fee < 0 then
            errors.add(:active_fee, "must be greater than or equal to 0.0")
          end
          
          if !active_fee.modulo(5).zero? then
            errors.add(:active_fee, "must be divisible by 0.5")
          end
        end        
      end
      
      if !fee.nil? && !active_fee.nil? && active_fee > fee then
        errors.add(:active_fee, "cannot be greater than fee")
      end
    end
    
end
