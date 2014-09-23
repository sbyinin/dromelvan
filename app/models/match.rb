class Match < ActiveRecord::Base
  
  belongs_to :home_team, class_name: Team, foreign_key: :home_team_id
  belongs_to :away_team, class_name: Team, foreign_key: :away_team_id
  belongs_to :match_day
  belongs_to :stadium
  has_many :goals, dependent: :restrict_with_exception
  has_many :cards, dependent: :restrict_with_exception
  has_many :substitutions, dependent: :restrict_with_exception

  # This would let us enter times in UTC and save them in that time in UTC.
  # I.e 15:00 would be save as 15:00 UTC instead of 13:00 UTC. But I'm not
  # sure we actually want that after all so we'll leave it here so we'll
  # remember how to do it if it turns out we want it and just comment it.
  # before_save { self.datetime = datetime + Time.zone.utc_offset }

  default_scope -> { order(:datetime) }
  scope :by_seasons, -> { joins(match_day: [premier_league: :season]) }

  after_initialize :init
  before_validation :update_default_properties, on: :create
  before_validation :update_elapsed
    
  validates :home_team, presence: true
  validates :away_team, presence: true
  validates :match_day, presence: true  
  validates :stadium, presence: true
  validates :home_team_goals, numericality: { greater_than_or_equal_to: 0 }
  validates :away_team_goals, numericality: { greater_than_or_equal_to: 0 }
  validates :datetime, presence: true
  validates :elapsed, presence: true
  validates :status, presence: true, inclusion: 0..2
  validates :whoscored_id, numericality: { greater_than: 0 }
  
  def name
    "#{home_team.name} vs #{away_team.name}"
  end
  
  def points(team)
    if home_team_goals == away_team_goals
      1      
    elsif team == home_team && home_team_goals > away_team_goals
      3
    elsif team == away_team && away_team_goals > home_team_goals
      3
    else
      0
    end
  end
  
  def goals_for(team)
    if team == home_team
      home_team_goals
    elsif team == away_team
      away_team_goals
    else
      0
    end
  end
  
  def goals_against(team)
    if team == home_team
      away_team_goals
    elsif team == away_team
      home_team_goals
    else
      0
    end
  end
  
  def Match.by_season(season)
    by_seasons.where(seasons: {id: season.id})
  end

  def Match.by_team(team)
    Match.where("matches.home_team_id = ? OR matches.away_team_id = ?", team.id, team.id)
  end

  def Match.by_date(date)
    Match.where(datetime: date.beginning_of_day..date.end_of_day)
  end

  def Match.match_dates
    match_dates = []
    pluck(:datetime).each do |match_date|
      match_dates += [ match_date.to_date ]
    end
    match_dates.uniq
  end
  
  private  
    def init
      self.status ||= 0
      self.elapsed ||= "N/A"
      self.home_team_goals ||= 0
      self.away_team_goals ||= 0
    end
    
    def update_default_properties
      if self.home_team.present? then
        self.stadium ||= home_team.stadium
      end
      
      if self.match_day.present? then
        self.datetime ||= self.match_day.date.to_time
      end      
    end
    
    def update_elapsed
      if self.status == 0
        self.elapsed = "N/A"
      elsif self.status == 2
        self.elapsed = "FT"
      end
    end
  
end
