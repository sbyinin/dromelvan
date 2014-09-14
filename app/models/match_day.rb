class MatchDay < ActiveRecord::Base
  
  belongs_to :premier_league
  
  default_scope -> { order(:date) }
  
  validates :premier_league, presence: true
  validates :date, presence: true
  validates :match_day_number, presence: true, inclusion: 1..38   
  
  def previous
    premier_league.match_days.where(match_day_number: match_day_number - 1).first
  end

  def next
    premier_league.match_days.where(match_day_number: match_day_number + 1).first
  end
  
  def MatchDay.current
    where("date <= ?", Date.today).last
  end
  
end
