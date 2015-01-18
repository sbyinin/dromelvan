class TransferBid < ActiveRecord::Base

  belongs_to :transfer_day
  belongs_to :player
  belongs_to :d11_team

  default_scope -> { order(:player_ranking, active_fee: :desc, d11_team_ranking: :desc) }

  after_initialize :init
  
  validates :transfer_day, presence: true
  validates :player, presence: true
  validates :player_ranking, numericality: { greater_than_or_equal_to: 0 }
  validates :d11_team, presence: true
  validates :d11_team_ranking, numericality: { greater_than_or_equal_to: 0 }
  validates :fee, numericality: { greater_than_or_equal_to: 5 }  
  validates :active_fee, numericality: { greater_than_or_equal_to: 5 }
  validates :successful, inclusion: [true, false]
  validate  :validate_fees
  
  
  private
    def init
      self.player_ranking ||= 0
      self.d11_team_ranking ||= 0
      self.successful ||= false
    end
  
    def validate_fees
      if !fee.nil? && !fee.modulo(5).zero? then
        errors.add(:fee, "must be divisible by 5")
      end

      if !active_fee.nil? && !active_fee.modulo(5).zero? then
        errors.add(:active_fee, "must be divisible by 5")
      end
      
      if !fee.nil? && !active_fee.nil? && active_fee > fee then
        errors.add(:active_fee, "cannot be greater than fee")
      end
    end
    
end
