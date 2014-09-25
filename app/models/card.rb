class Card < ActiveRecord::Base
  include MatchEvent

  enum card_type: [:yellow, :red ]
  
  validates :card_type, presence: true
  
end
