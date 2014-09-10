class Team < ActiveRecord::Base
  include NameScope
    
  belongs_to :stadium

  default_scope -> { order('name') }

  after_initialize :init

  has_attached_file :club_crest, styles: { icon: [ "16x16^", :png], tiny: ["32x32^", :png], small: ["64x64^", :png], large: ["128x128^", :png] },
                                 convert_options: {
                                    icon: "-gravity Center -crop 16x16+0+0 +repage",
                                    tiny: "-gravity Center -crop 32x32+0+0 +repage",
                                    small: "-gravity Center -crop 64x64+0+0 +repage",
                                    large: "-gravity Center -crop 128x128+0+0 +repage"
                                  },
                                  default_url: "/assets/missing/club_crest-:style.png",
                                  url: "/images/club_crest/:style/:id.:extension",
                                  path: ":rails_root/public/images/club_crest/:style/:id.:extension"

  validates :stadium, presence: true
  validates :whoscored_id, numericality: { greater_than: 0 }
  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :code, presence: true, uniqueness: { case_sensitive: false }
  validates_length_of :code, :is => 3
  validates :established, presence: true, inclusion: 1800..2020
  validates :colour, format: { with: /\A#[A-Z0-9]{6}\z/ }
  
  validates_attachment_size :club_crest, less_than: 5.megabytes
  validates_attachment_content_type :club_crest, content_type: [ "image/jpeg", "image/jpg", "image/gif", "image/png" ]

  private  
    def init
      self.colour ||= "#000000"
    end

end
