class D11MatchDay < ActiveRecord::Base

  belongs_to :d11_league, touch: true
  belongs_to :match_day
  has_many :d11_matches, dependent: :restrict_with_exception
  has_one :transfer_window, dependent: :restrict_with_exception
  has_many :d11_team_table_stats, dependent: :restrict_with_exception

  default_scope -> { order(:date) }

  # TODO: Figure out why this is needed for the has_one in Season for the tests to
  # pass and how to change it if it's not needed.
  after_destroy { match_day.d11_match_day = nil }
  
  validates :d11_league, presence: true
  validates :match_day, presence: true
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

  def match_dates
    match_dates = []
    d11_matches.each do |d11_match|
      datetime = Match.by_d11_match(d11_match).pluck(:datetime).last
      if !datetime.nil?
        # Datetime shouldn't be nil if the database is set up right but check just in case.
        match_dates += [ Match.by_d11_match(d11_match).pluck(:datetime).last.to_date ]
      end      
    end
    match_dates.uniq.sort
  end
  
  def D11MatchDay.current
    where("date <= ?", Date.today).last
  end

end
