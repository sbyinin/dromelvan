class TeamRegistration < ActiveRecord::Base
  belongs_to :season
  belongs_to :team

  validates :season, presence: true
  validates :team, presence: true
  validates :team_id, uniqueness: {scope: :season_id} 
  
end
