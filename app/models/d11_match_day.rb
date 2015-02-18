class D11MatchDay < ActiveRecord::Base

  belongs_to :d11_league
  has_many :d11_matches, dependent: :restrict_with_exception
  has_one :transfer_window, dependent: :restrict_with_exception
  has_many :d11_team_table_stats, dependent: :restrict_with_exception

  default_scope -> { order(:date) }
  
  validates :d11_league, presence: true
  validates :date, presence: true
  validates :match_day_number, presence: true, inclusion: 1..38   

  def name
    "Match Day #{match_day_number}"
  end

  def previous
    d11_league.d11_match_days.where(match_day_number: match_day_number - 1).first
  end

  def next
    d11_league.d11_match_days.where(match_day_number: match_day_number + 1).first
  end

  def match_day
    # TODO add a match_day_id instead.
    if !d11_league.season.premier_league.nil?
      d11_league.season.premier_league.match_days.where(match_day_number: match_day_number).first
    end    
  end
  
  def D11MatchDay.current
    where("date <= ?", Date.today).last
  end

end
