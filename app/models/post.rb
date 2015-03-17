class Post < ActiveRecord::Base
  
  belongs_to :user
  
  default_scope -> { order(updated_at: :desc, id: :desc) }
  
  validates :user, presence: true
  validates :title, presence: true
  validates :content, presence: true 
  
end
