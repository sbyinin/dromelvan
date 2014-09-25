class Season < ActiveRecord::Base
  include NameScope

  has_one :premier_league, dependent: :restrict_with_exception
  has_one :d11_league, dependent: :restrict_with_exception
  has_many :player_season_infos, dependent: :restrict_with_exception

  enum status: [ :pending, :active, :finished ]
 
  default_scope -> { order(date: :desc) }

  after_initialize :init
  
  validates :name, uniqueness: { case_sensitive: false }, presence: true
  validates :status, presence: true
  validates :date, presence: true
  validates :legacy, inclusion: [true, false]
  
  def Season.current
    Season.all.first
  end
    
  private  
    def init
      self.status ||= 0
      self.legacy ||= false
    end
  
end
