class D11TeamRegistration < ActiveRecord::Base
  belongs_to :season
  belongs_to :d11_team
  
  after_initialize :init
  
  validates :season, presence: true
  validates :d11_team, presence: true
  validates :d11_team_id, uniqueness: {scope: :season_id} 
  validates :approved, inclusion: [true, false]
  
  private
    def init
      self.approved ||= false
    end
  
end
