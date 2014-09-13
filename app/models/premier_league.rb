class PremierLeague < ActiveRecord::Base
  
  belongs_to :season
  
  validates :name, presence: true
  validates :season, presence: true

  def PremierLeague.current
    Season.current.premier_league
  end
  
end
