class TransferWindow < ActiveRecord::Base
  
  belongs_to :season
  belongs_to :d11_match_day
  
  enum status: [ :pending, :active, :finished ]
  
  default_scope -> { order(datetime: :desc) }
  
  # TODO: Figure out why this is needed for the has_one in D11MatchDay for the tests to
  # pass and how to change it if it's not needed.
  after_destroy { d11_match_day.transfer_window = nil }
  
  validates :season, presence: true
  validates :d11_match_day, presence: true
  validates :transfer_window_number, presence: true, numericality: { greater_than_or_equal_to: 0, only_integer: true }
  validates :status, presence: true
  validates :datetime, presence: true
  
  def TransferWindow.current
    TransferWindow.all.first
  end
  
  def name
    if transfer_window_number == 0
      "Pre-season"
    else
      "Transfer window #{transfer_window_number}"
    end
  end

  def previous
    TransferWindow.where(season: season, transfer_window_number: transfer_window_number - 1).first
  end

  def next
    TransferWindow.where(season: season, transfer_window_number: transfer_window_number + 1).first
  end
  
  
end
