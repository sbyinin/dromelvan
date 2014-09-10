class Stadium < ActiveRecord::Base
  include NameScope

  default_scope -> { order('name ASC') }
  
  has_attached_file :photo, styles: { icon: [ "32x100>", :png], thumbnail: [ "100x100>", :png], original: ["960x610#", :png] },                                      
                            default_url: "/assets/missing/stadium-:style.png",
                            url: "/images/stadium/:style/:id.:extension",
                            path: ":rails_root/public/images/stadium/:style/:id.:extension"
  
  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :city, presence: true
  validates :capacity, presence: true, numericality: { greater_than: 0 }
  validates :opened, presence: true, inclusion: 1800..2020
  
  validates_attachment_size :photo, less_than: 5.megabytes
  validates_attachment_content_type :photo, content_type: [ "image/jpeg", "image/jpg", "image/gif", "image/png" ]
  
end
