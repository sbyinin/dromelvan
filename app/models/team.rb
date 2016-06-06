class Team < ActiveRecord::Base
  include NameScope
  include TeamPlayers
    
  belongs_to :stadium
  has_many :home_matches, class_name: Match, foreign_key: :home_team_id, dependent: :restrict_with_exception
  has_many :away_matches, class_name: Match, foreign_key: :away_team_id, dependent: :restrict_with_exception
  has_many :player_match_stats, dependent: :restrict_with_exception  
  has_many :goals, dependent: :restrict_with_exception
  has_many :cards, dependent: :restrict_with_exception
  has_many :substitutions, dependent: :restrict_with_exception  
  has_many :player_season_infos, dependent: :restrict_with_exception
  has_many :transfer_listings, dependent: :restrict_with_exception
  has_many :team_table_stats, dependent: :restrict_with_exception
  has_many :team_registrations, dependent: :restrict_with_exception
  has_many :team_match_squad_stats, dependent: :restrict_with_exception
  has_many :team_season_squad_stats, dependent: :restrict_with_exception

  default_scope -> { order(name: :asc) }

  after_initialize :init

  has_attached_file :club_crest, styles: { icon: [ "16x16^", :png], tiny: ["32x32^", :png], small: ["64x64^", :png], large: ["128x128^", :png] },
                                 convert_options: {
                                    icon: "-gravity Center -crop 16x16+0+0 +repage",
                                    tiny: "-gravity Center -crop 32x32+0+0 +repage",
                                    small: "-gravity Center -crop 64x64+0+0 +repage",
                                    large: "-gravity Center -crop 128x128+0+0 +repage"
                                  },
                                  default_url: "/assets/missing/club-crest-:style.png",
                                  url: "/images/club_crest/:style/:id.:extension",
                                  path: ":rails_root/public/images/club_crest/:style/:id.:extension"

  validates :stadium, presence: true
  validates :whoscored_id, numericality: { greater_than: 0 }
  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :code, presence: true, uniqueness: { case_sensitive: false }
  validates_length_of :code, :is => 3
  validates :established, presence: true, inclusion: 1800..2020
  validates :colour, format: { with: /\A#[A-Z0-9]{6}\z/ }
  validates :dummy, inclusion: [true, false] 
  
  validates_attachment_size :club_crest, less_than: 5.megabytes
  validates_attachment_content_type :club_crest, content_type: [ "image/jpeg", "image/jpg", "image/gif", "image/png" ]

  def form_matches(match_day, count = 5)
    matches = Match.joins(:match_day).by_team(self).by_season(match_day.premier_league.season).where(status: 2).where('match_day_number <= ?', match_day.match_day_number)
    if matches.nil?
      matches = []
    end
    if matches.size > count
      matches = matches[-count..-1]
    end
    matches
  end

  def form(season, count = 5)
    form = []
    matches = Match.by_team(self).by_season(season)
    matches.each do |match|
      if match.finished?
        points = match.points(self)
        if points == 3
          form << :win
        elsif points == 1
          form << :draw
        else
          form << :loss
        end
      end
    end
    form[-count..-1]
  end

  def form_d11_points(season, count = 5)
    form_d11_points = []
    matches = Match.by_team(self).by_season(season)
    matches.each do |match|
      if match.finished?
        team_match_squad_stat = match.team_match_squad_stats.where(team: self).first
        if !team_match_squad_stat.nil?
          points = team_match_squad_stat.points
          form_d11_points << points
        end
        form_d11_points << 4
      end
    end
    form_d11_points[-count..-1]
  end
  
  private  
    def init
      self.colour ||= "#000000"
      self.dummy ||= false
    end

end
