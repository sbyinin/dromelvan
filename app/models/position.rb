class Position < ActiveRecord::Base

  has_many :player_match_stats, dependent: :restrict_with_exception
  has_many :player_season_infos, dependent: :restrict_with_exception

  default_scope -> { order(sort_order: :asc) }
  
  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :defender, inclusion: [true, false]
  validates :code, presence: true, uniqueness: { case_sensitive: false }
  validates :sort_order, presence: true, uniqueness: true, numericality: { greater_than: 0 }

end
