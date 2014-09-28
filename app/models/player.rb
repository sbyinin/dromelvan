class Player < ActiveRecord::Base
  
  belongs_to :country
  has_many :player_match_stats, dependent: :restrict_with_exception
  has_many :goals, dependent: :restrict_with_exception
  has_many :cards, dependent: :restrict_with_exception
  has_many :substitutions, dependent: :restrict_with_exception
  has_many :in_substitutions, class_name: Substitution, foreign_key: :player_in_id, dependent: :restrict_with_exception 
  has_many :player_season_infos, dependent: :restrict_with_exception
  has_many :player_season_stats, dependent: :restrict_with_exception

  has_attached_file :player_photo, styles: { icon: [ "16x16^", :png], tiny: ["32x32^", :png], small: ["64x64^", :png], large: ["128x128^", :png] },
                                   convert_options: {
                                    icon: "-gravity Center -crop 16x16+0+0 +repage",
                                    tiny: "-gravity Center -crop 32x32+0+0 +repage",
                                    small: "-gravity Center -crop 64x64+0+0 +repage",
                                    large: "-gravity Center -crop 128x128+0+0 +repage"
                                    },
                                   default_url: "/assets/missing/player-photo-:style.png",
                                   url: "/images/player-photo/:style/:id.:extension",
                                   path: ":rails_root/public/images/player-photo/:style/:id.:extension"
  
  after_initialize :init
  before_validation :parameterize_name

  default_scope -> { order(last_name: :asc, first_name: :asc) }

  validates :first_name, length: { minimum: 0, allow_nil: false, message: "can't be nil" }
  validates :last_name, presence: true
  validates :parameterized_name, presence: true
  validates :country, presence: true
  validates :height, numericality: { greater_than_or_equal_to: 0 }
  validates :weight, numericality: { greater_than_or_equal_to: 0 }
  validates :whoscored_id, numericality: { greater_than_or_equal_to: 0, allow_nil: true }
  
  validates_attachment_size :player_photo, less_than: 5.megabytes
  validates_attachment_content_type :player_photo, content_type: [ "image/jpeg", "image/jpg", "image/gif", "image/png" ]
  
  
  def name
    "#{first_name} #{last_name}".strip
  end
  
  def reversed_name
    "#{last_name} #{first_name}".strip    
  end

  def short_name
    "#{last_name} #{first_name[0]}".strip    
  end
  
  def season_info(season)
    player_season_info = player_season_infos.where(season: season).first
    if player_season_info.nil?
      player_season_info = PlayerSeasonInfo.new(player: self, season: season)
    end
    player_season_info
  end
  
  def Player.named(name)
    if !name.blank? then
      if name.match('\"(.*)\"') then
        where(parameterized_name: name.parameterize)
      else
        # Turn 'foo bar' into ['foo', 'foo', 'foo', 'bar', 'bar', 'bar'] to match the two terms in the query.
        # It doesn't matter if foo or bar comes first, the result will be the same.
        name_terms = name.split
        name_count = name_terms.length
        name_terms = (name_terms + name_terms + name_terms).sort
                
        # This makes an array ['f_n like ? or l_n like ? or p_n like ?', 'f_n like ? or l_n like ? or p_n like ?',] etc with name_count entries. It then joins them with AND,
        # creating ['f_n like ? or l_n like ? or p_n like ? AND f_n like ? or l_n like ? or p_n like ?',] etc. It then adds the search terms creating the final parameter for where:
        # ['f_n like ? or l_n like ? or p_n like ? AND f_n like ? or l_n like ? or p_n like ?', 'foo', 'foo', 'foo', 'bar', 'bar', 'bar']
        where( [(['(first_name LIKE ? OR last_name LIKE ? OR parameterized_name LIKE ?)'] * name_count).join(' AND ')] + name_terms.map { |name_term| "%#{name_term}%" } )
      end      
    else
      # No point doing a DB query if the search term is blank. We'll just return an empty relation instead.
      none
    end  
  end

  def age
    if !self.date_of_birth.nil?
      self.date_of_birth.find_age
    else
      nil
    end
  end

  private  
    def init
      self.first_name ||= ""
      self.last_name ||= ""
      self.country ||= Country.where(name: "Unknown").first
      self.height ||= 0
      self.weight ||= 0
    end

    def parameterize_name
      self.parameterized_name = self.name.strip.parameterize
    end
end
