class Country < ActiveRecord::Base
  include NameScope

  has_many :players, dependent: :restrict_with_exception

  default_scope -> { order :name }
  
  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :iso, presence: true, uniqueness: { case_sensitive: false }
  
  validates_length_of :iso, in: 2..3

end
