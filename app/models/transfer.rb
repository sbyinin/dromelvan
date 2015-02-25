class Transfer < ActiveRecord::Base
  belongs_to :transfer_day
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
