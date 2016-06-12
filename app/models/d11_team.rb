class D11Team < ActiveRecord::Base
  include NameScope
  include TeamPlayers
  
  belongs_to :owner, class_name: :User, foreign_key: :owner_id
  belongs_to :co_owner, class_name: :User, foreign_key: :co_owner_id
  has_many :home_d11_matches, class_name: D11Match, foreign_key: :home_d11_team_id, dependent: :restrict_with_exception
  has_many :away_d11_matches, class_name: D11Match, foreign_key: :away_d11_team_id, dependent: :restrict_with_exception    
  has_many :player_match_stats, dependent: :restrict_with_exception
  has_many :player_season_infos, dependent: :restrict_with_exception
  has_many :transfer_listings, dependent: :restrict_with_exception
  has_many :d11_team_table_stats, dependent: :restrict_with_exception
  has_many :d11_team_registrations, dependent: :restrict_with_exception
  has_many :d11_team_match_squad_stats, dependent: :restrict_with_exception
  has_many :d11_team_season_squad_stats, dependent: :restrict_with_exception

  default_scope -> { order(name: :asc) }
  
  has_attached_file :club_crest, styles: { icon: [ "16x16^", :png], tiny: ["32x32^", :png], small: ["64x64^", :png], large: ["128x128^", :png] },
                                 convert_options: {
                                    icon: "-gravity Center -crop 16x16+0+0 +repage",
                                    tiny: "-gravity Center -crop 32x32+0+0 +repage",
                                    small: "-gravity Center -crop 64x64+0+0 +repage",
                                    large: "-gravity Center -crop 128x128+0+0 +repage"
                                  },
                                  default_url: "/assets/missing/club-crest-:style.png",
                                  url: "/images/d11_club_crest/:style/:id.:extension",
                                  path: ":rails_root/public/images/d11_club_crest/:style/:id.:extension"

  validates :owner, presence: true
  validates :name, presence: true, length: { maximum: 25 }, uniqueness: { case_sensitive: false }
  validates :code, uniqueness: { case_sensitive: false, allow_blank: true }
  validates_length_of :code, is: 3, allow_nil: true
  validates :dummy, inclusion: [true, false] 

  validates_attachment_size :club_crest, less_than: 5.megabytes
  validates_attachment_content_type :club_crest, content_type: [ "image/jpeg", "image/jpg", "image/gif", "image/png" ]

  def form_matches(d11_match_day, count = 5)
    #d11_matches = D11Match.by_d11_team(self).by_season(season).where(status: 2)
    d11_matches = D11Match.joins(:d11_match_day).by_d11_team(self).by_season(d11_match_day.d11_league.season).where(status: 2).where('match_day_number <= ?', d11_match_day.match_day_number)
    if d11_matches.nil?
      d11_matches = []
    end
    if d11_matches.size > count
      d11_matches = d11_matches[-count..-1]
    end    
    d11_matches
  end

  def form(season, count = 5)
    form = []
    d11_matches = D11Match.by_d11_team(self).by_season(season)
    d11_matches.each do |d11_match|
      if d11_match.finished?
        points = d11_match.points(self)
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
    d11_matches = D11Match.by_d11_team(self).by_season(season)
    d11_matches.each do |d11_match|
      if d11_match.finished?
        d11_team_match_squad_stat = d11_match.d11_team_match_squad_stats.where(d11_team: self).first
        if !d11_team_match_squad_stat.nil?
          points = d11_team_match_squad_stat.points
          form_d11_points << points
        end
        form_d11_points << 4
      end
    end
    form_d11_points[-count..-1]
  end

  private  
    def init
      self.dummy ||= false
    end

end
