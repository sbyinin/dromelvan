class TransferDay < ActiveRecord::Base

  belongs_to :transfer_window
  has_many :transfer_listings, dependent: :restrict_with_exception
  
  enum status: [ :pending, :active, :finished ]
  
  default_scope -> { order(datetime: :desc) }
  
  validates :transfer_window, presence: true
  validates :transfer_day_number, presence: true, numericality: { greater_than_or_equal_to: 0, only_integer: true }
  validates :status, presence: true
  validates :datetime, presence: true

  def TransferDay.current
    TransferDay.all.first
  end
  
  def name
    "Transfer day #{transfer_day_number}"
  end

  def previous
    TransferDay.where(transfer_window: transfer_window, transfer_day_number: transfer_day_number - 1).first
  end

  def next
    TransferDay.where(transfer_window: transfer_window, transfer_day_number: transfer_day_number + 1).first
  end

end
