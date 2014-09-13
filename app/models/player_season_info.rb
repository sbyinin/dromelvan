class PlayerSeasonInfo < ActiveRecord::Base
  
  belongs_to :player
  belongs_to :season
  belongs_to :team
  belongs_to :d11_team
  belongs_to :position

  after_initialize :init
  
  validates :player, presence: true
  validates :season, presence: true
  validates :team, presence: true
  validates :d11_team, presence: true
  validates :position, presence: true
  validates :value, presence: true, inclusion: 0..500
  validates :player_id, uniqueness: {scope: :season_id} 
  
  private  
    def init
      self.team ||= Team.where(name: "None").first
      self.d11_team ||= D11Team.where(name: "None").first
      self.value ||= 0
    end
  
end
