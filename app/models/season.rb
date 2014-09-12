class Season < ActiveRecord::Base
  include NameScope

  default_scope -> { order(date: :desc) }

  after_initialize :init
  
  validates :name, uniqueness: { case_sensitive: false }, presence: true
  validates :status, presence: true, inclusion: 0..2
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
