class Transfer < ActiveRecord::Base
  belongs_to :transfer_day, touch: true
  belongs_to :player
  belongs_to :d11_team

  # Todo - do this with symbols instead of a string
  default_scope -> { joins(:transfer_day).order("transfer_days.datetime desc") } 

  after_initialize :init
  
  validates :transfer_day, presence: true
  validates :player, presence: true
  validates :d11_team, presence: true  
  validates :fee, numericality: { greater_than_or_equal_to: 0 }
  validate  :validate_fee
  
  def Transfer.create_for(transfer_day)
    TransferBid.where(transfer_day: transfer_day, successful: true).each do |transfer_bid|
      transfer = Transfer.new(transfer_day: transfer_day)
      transfer.player = transfer_bid.player
      transfer.d11_team = transfer_bid.d11_team
      transfer.fee = transfer_bid.fee
      transfer.save
      
      player_season_info = PlayerSeasonInfo.where(player: transfer.player, season: transfer_day.transfer_window.season).take
      player_season_info.d11_team = transfer.d11_team
      player_season_info.value = transfer.fee
      player_season_info.save
    end
  end
  
  private
    def init
      self.fee ||= 0
    end
  
    def validate_fee
      if !transfer_day.nil? && !transfer_day.transfer_window.season.legacy? && !fee.nil? && !fee.modulo(5).zero? then
        errors.add(:fee, "must be divisible by 5")
      end
    end
    
end
