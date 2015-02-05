class D11TeamTableStat < ActiveRecord::Base
  include TableStat
  
  belongs_to :d11_team
  belongs_to :d11_league
  belongs_to :d11_match_day

  scope :combined_ordered, -> { joins(:d11_team).reorder('points DESC, goals_for DESC, goals_against DESC, d11_teams.name ASC').readonly(false) }
  scope :home_ordered, -> { joins(:d11_team).reorder('home_points DESC, home_goals_for DESC, home_goals_against DESC, d11_teams.name ASC').readonly(false) }
  scope :away_ordered, -> { joins(:d11_team).reorder('away_points DESC, away_goals_for DESC, away_goals_against DESC, d11_teams.name ASC').readonly(false) }
  scope :date_ordered, -> { joins(:d11_match_day).reorder('d11_match_days.date').readonly(false) }
  
  validates :d11_team, presence: true
  validates :d11_league, presence: true
  validates :d11_match_day, presence: true
    
end
