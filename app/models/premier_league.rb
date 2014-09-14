class PremierLeague < ActiveRecord::Base
  include SeasonUniqueName
  
  belongs_to :season

  # TODO: Figure out why this is needed for the has_one in Season for the tests to
  # pass and how to change it if it's not needed.
  after_destroy { season.premier_league = nil }
  
  validates :name, presence: true
  validates :season, presence: true
 
  def PremierLeague.current
    Season.current.premier_league unless Season.current.nil?
  end
  
end
