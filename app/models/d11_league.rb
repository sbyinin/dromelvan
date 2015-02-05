class D11League < ActiveRecord::Base
  include SeasonUniqueName  
  
  belongs_to :season
  has_many :d11_match_days, dependent: :restrict_with_exception
  has_many :d11_team_table_stats, dependent: :restrict_with_exception
  
  # TODO: Figure out why this is needed for the has_one in Season for the tests to
  # pass and how to change it if it's not needed.
  after_destroy { season.d11_league = nil }

  validates :name, presence: true
  validates :season, presence: true

  def D11League.current
    Season.current.d11_league unless Season.current.nil?
  end

end
