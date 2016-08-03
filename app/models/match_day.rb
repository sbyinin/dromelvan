class MatchDay < ActiveRecord::Base
  
  belongs_to :premier_league, touch: true
  has_one :d11_match_day, dependent: :restrict_with_exception
  has_many :matches, dependent: :restrict_with_exception
  has_many :team_table_stats, dependent: :restrict_with_exception
  
  enum status: [ :pending, :active, :finished ]
  
  default_scope -> { order(:date) }

  after_initialize :init

  validates :premier_league, presence: true
  validates :date, presence: true
  validates :match_day_number, presence: true, inclusion: 1..38
  validates :status, presence: true    

  def name
    "Match Day #{match_day_number}"
  end
  
  def previous
    premier_league.match_days.where(match_day_number: match_day_number - 1).first
  end

  def next
    premier_league.match_days.where(match_day_number: match_day_number + 1).first
  end

  def match_dates
    match_dates = []
    matches.pluck(:datetime).each do |match_date|
      match_dates += [ match_date.to_date ]
    end
    match_dates.uniq.sort
  end

  # For rails_admin. TODO: Figure out how to move this to StatusEnum.
  def status_enum
    ['pending', 'active', 'finished']
  end    
  
  def MatchDay.current
    match_day = PremierLeague.current.match_days.where("date <= ?", Date.today).last
    if match_day.nil?
      match_day = PremierLeague.current.match_days.first
    end
    match_day
  end

  private
    def init
      self.status ||= 0
    end
  
end
