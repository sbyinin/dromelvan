module MatchEvent
  extend ActiveSupport::Concern
  
  included do
    belongs_to :match
    belongs_to :team
    belongs_to :player

    default_scope -> { order(:time, :added_time) }

    validates :match, presence: true
    validates :team, presence: true
    validates :player, presence: true    
    validates :time, presence: true, inclusion: 1..90
    validates :added_time, numericality: { greater_than_or_equal_to: 0 }
    
    validate :validate_added_time

    after_initialize :init_match_event

    private
      def init_match_event
        self.time ||= 0
        self.added_time ||= 0
      end
    
      def validate_added_time
        if self.added_time != 0 && ![45,90].include?(time)
          errors.add(:added_time, " can only be greater than 0 if time is 45 or 90")
        end
      end        
  end
  
  module ClassMethods
    def by_d11_match_day_and_d11_team(d11_match_day, d11_team)
      joins(match: :player_match_stats).where(matches: { match_day_id: d11_match_day.match_day.id }).where("player_match_stats.player_id = #{name.tableize}.player_id").where(player_match_stats: { d11_team_id: d11_team.id })
    end    
  end
    
end