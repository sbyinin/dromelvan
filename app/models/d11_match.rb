class D11Match < ActiveRecord::Base
  
  belongs_to :home_d11_team, class_name: D11Team, foreign_key: :home_d11_team_id
  belongs_to :away_d11_team, class_name: D11Team, foreign_key: :away_d11_team_id
  belongs_to :d11_match_day

  enum status: [ :pending, :active, :finished ]
  
  default_scope -> { joins(:d11_match_day).order('d11_match_days.date').readonly(false) }
  scope :by_seasons, -> { joins(d11_match_day: [d11_league: :season]) }

  after_initialize :init  
  before_validation :update_goals

  validates :home_d11_team, presence: true
  validates :away_d11_team, presence: true
  validates :d11_match_day, presence: true  
  validates :home_team_goals, numericality: { greater_than_or_equal_to: 0 }
  validates :away_team_goals, numericality: { greater_than_or_equal_to: 0 }
  validates :home_team_points, presence: true
  validates :away_team_points, presence: true
  validates :status, presence: true

  def name
    "#{home_d11_team.name} vs #{away_d11_team.name}"
  end
  
  def points(d11_team)
    update_goals
    if home_team_goals == away_team_goals
      1      
    elsif d11_team == home_d11_team && home_team_goals > away_team_goals
      3
    elsif d11_team == away_d11_team && away_team_goals > home_team_goals
      3
    else
      0
    end
  end
  
  def goals_for(d11_team)
    if d11_team == home_d11_team
      home_team_goals
    elsif d11_team == away_d11_team
      away_team_goals
    else
      0
    end
  end
  
  def goals_against(d11_team)
    if d11_team == home_d11_team
      away_team_goals
    elsif d11_team == away_d11_team
      home_team_goals
    else
      0
    end
  end
  
  def D11Match.by_season(season)
    by_seasons.where(seasons: {id: season.id})
  end
  
  def D11Match.by_d11_team(d11_team)
    D11Match.where("d11_matches.home_d11_team_id = ? OR d11_matches.away_d11_team_id = ?", d11_team.id, d11_team.id)
  end
  
  private
    def init
      self.home_team_goals ||= 0
      self.away_team_goals ||= 0
      self.home_team_points ||= 0
      self.away_team_points ||= 0            
      self.status ||= 0
    end
  
    def update_goals
      self.home_team_points ||= 0
      self.away_team_points ||= 0      
      
      if self.home_team_points > 0 then
        self.home_team_goals = (home_team_points / 5) + 1
      else
        self.home_team_goals = 0
      end
      
      if self.away_team_points > 0 then
        self.away_team_goals = (away_team_points / 5) + 1
      else
        self.away_team_goals = 0
      end
    end
  
end
