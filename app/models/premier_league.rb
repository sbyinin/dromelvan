class PremierLeague < ActiveRecord::Base
  include SeasonUniqueName
  
  belongs_to :season, touch: true
  has_many :match_days, dependent: :restrict_with_exception
  has_many :team_table_stats, dependent: :restrict_with_exception

  # TODO: Figure out why this is needed for the has_one in Season for the tests to
  # pass and how to change it if it's not needed.
  after_destroy { season.premier_league = nil }
  
  validates :name, presence: true
  validates :season, presence: true

  def winner    
    team_table_stats.where(match_day: match_days.last).order(ranking: :asc).first
  end
  
  def runners_up
    team_table_stats.where(match_day: match_days.last).order(ranking: :asc)[1..2]
  end
 
  def PremierLeague.current
    Season.current.premier_league unless Season.current.nil?
  end
  
end
