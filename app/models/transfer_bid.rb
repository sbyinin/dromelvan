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
          errors.add(:fee, "must be greater than or equal to 0")
        end          

        if !active_fee.nil? && active_fee < 0 then
          errors.add(:active_fee, "must be greater than or equal to 0")
        end                  
      else
        if !fee.nil?
          if fee < 5 then
            errors.add(:fee, "must be greater than or equal to 5")
          end

          if !fee.modulo(5).zero? then
            errors.add(:fee, "must be divisible by 5")
          end          
        end        

        if !active_fee.nil? then
          if active_fee < 0 then
            errors.add(:active_fee, "must be greater than or equal to 0")
          end
          
          if !active_fee.modulo(5).zero? then
            errors.add(:active_fee, "must be divisible by 5")
          end
        end        
      end
      
      if !fee.nil? && !active_fee.nil? && active_fee > fee then
        errors.add(:active_fee, "cannot be greater than fee")
      end
    end
    
end
