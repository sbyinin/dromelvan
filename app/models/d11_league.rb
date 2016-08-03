class D11League < ActiveRecord::Base
  include SeasonUniqueName  
  
  belongs_to :season, touch: true
  has_many :d11_match_days, dependent: :restrict_with_exception
  has_many :d11_team_table_stats, dependent: :restrict_with_exception
  
  # TODO: Figure out why this is needed for the has_one in Season for the tests to
  # pass and how to change it if it's not needed.
  after_destroy { season.d11_league = nil }

  validates :name, presence: true
  validates :season, presence: true

  def winner    
    d11_team_table_stats.where(d11_match_day: d11_match_days.last).order(ranking: :asc).first
  end
  
  def runners_up
    d11_team_table_stats.where(d11_match_day: d11_match_days.last).order(ranking: :asc)[1..2]
  end

  def D11League.current
    Season.current.d11_league unless Season.current.nil?
  end

  def current_d11_match_day
    d11_match_day = d11_match_days.where("date <= ?", Date.today).last
    if d11_match_day.nil?
      d11_match_day = d11_match_days.first
    end
    d11_match_day    
  end

end
