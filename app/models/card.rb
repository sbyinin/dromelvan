class Card < ActiveRecord::Base
  include MatchEvent
  
  validates :card_type, presence: true, inclusion: 0..1
  
end
