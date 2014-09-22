class Goal < ActiveRecord::Base
  include MatchEvent
  
  validates :penalty, inclusion: [true, false]
  validates :own_goal, inclusion: [true, false]
  validate :validate_penalty_and_own_goal
  
  private
    def validate_penalty_and_own_goal
      if penalty && own_goal
        errors.add(:penalty, "cannot be an own goal")
      end
    end
  
end
