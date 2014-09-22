class Substitution < ActiveRecord::Base
  include MatchEvent
  
  belongs_to :player_in, class_name: Player, foreign_key: :player_in_id
  
  validates :player_in, presence: true  
  validate :validate_players
  
  private
    def validate_players
      if player == player_in
        errors.add(:player_in, "cannot be the same player as the one that is substituted")
      end
    end   
end
