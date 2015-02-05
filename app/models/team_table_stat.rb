class TeamTableStat < ActiveRecord::Base
  include TableStat
  
  belongs_to :team
  belongs_to :premier_league
  belongs_to :match_day
  
  scope :combined_ordered, -> { joins(:team).reorder('points DESC, goal_difference DESC, goals_for DESC, teams.name ASC').readonly(false) }
  scope :home_ordered, -> { joins(:team).reorder('home_points DESC, home_goal_difference DESC, home_goals_for DESC, teams.name ASC').readonly(false) }
  scope :away_ordered, -> { joins(:team).reorder('away_points DESC, away_goal_difference DESC, away_goals_for DESC, teams.name ASC').readonly(false) }
  scope :date_ordered, -> { joins(:match_day).reorder('match_days.date, match_days.match_day_number').readonly(false) }
  
  validates :team, presence: true
  validates :premier_league, presence: true
  validates :match_day, presence: true
  
end
