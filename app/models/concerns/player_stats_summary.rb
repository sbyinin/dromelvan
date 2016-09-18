module PlayerStatsSummary
  extend ActiveSupport::Concern
  include PlayerStats

  included do
    after_initialize :init_stats_summary
    before_validation :summarize_stats

    validates :clean_sheets, numericality: { greater_than_or_equal_to: 0 }
    validates :yellow_cards, numericality: { greater_than_or_equal_to: 0 }
    validates :red_cards, numericality: { greater_than_or_equal_to: 0 }
    validates :man_of_the_match, numericality: { greater_than_or_equal_to: 0 }
    validates :shared_man_of_the_match, numericality: { greater_than_or_equal_to: 0 }
    validates :games_started, numericality: { greater_than_or_equal_to: 0 }
    validates :games_substitute, numericality: { greater_than_or_equal_to: 0 }
    validates :games_did_not_participate, numericality: { greater_than_or_equal_to: 0 }
    validates :points_per_appearance, presence: true, numericality: { only_integer: true }
    validates :substitutions_on, numericality: { greater_than_or_equal_to: 0 }
    validates :substitutions_off, numericality: { greater_than_or_equal_to: 0 }
    validates :minutes_played, numericality: { greater_than_or_equal_to: 0 }
    
    def appearances
      games_started + games_substitute
    end
    
    def points_per_appearance_s
      '%.2f' % (points_per_appearance.to_f / 100)
    end
    
    def summarize_stats
      reset_stats_summary
      games_rated = 0

      player_match_stats.each do |player_match_stat|
        self.goals += player_match_stat.goals
        self.goal_assists += player_match_stat.goal_assists
        self.own_goals += player_match_stat.own_goals
        
        if player_match_stat.participated? then
          self.rating += player_match_stat.rating
          if player_match_stat.rating > 0
            games_rated += 1
          end

          if player_match_stat.position.defender? then
            self.goals_conceded += player_match_stat.goals_conceded
            if player_match_stat.goals_conceded == 0 then
              self.clean_sheets += 1
            end
          end
        end
        
        self.points += player_match_stat.points
        
        if player_match_stat.yellow_card_time > 0 then
          self.yellow_cards += 1
        end
        
        if player_match_stat.red_card_time > 0 then
          self.red_cards += 1
        end
        
        if player_match_stat.man_of_the_match? then
          self.man_of_the_match += 1
        end
        
        if player_match_stat.shared_man_of_the_match? then
          self.shared_man_of_the_match += 1
        end
        
        if player_match_stat.starting_lineup? then
          self.games_started += 1
        end
        
        if player_match_stat.substitute? then
          self.games_substitute += 1
        end
        
        if player_match_stat.did_not_participate? then
          self.games_did_not_participate += 1
        end
        
        if player_match_stat.substitution_on_time > 0 then
          self.substitutions_on += 1
        end

        if player_match_stat.substitution_off_time > 0 then
          self.substitutions_off += 1
        end
        
        self.minutes_played += player_match_stat.minutes_played 
      end
            
      if games_rated > 0 then
        self.rating = (self.rating.to_f / games_rated.to_f).round
      end
      
      if appearances > 0 then
        self.points_per_appearance = ((self.points.to_f / appearances.to_f).round(2) * 100).to_i
      end
    end

    def init_from(player_stats_summary)
        self.goals = player_stats_summary.goals
        self.goal_assists = player_stats_summary.goal_assists
        self.own_goals = player_stats_summary.own_goals
        self.goals_conceded = player_stats_summary.goals_conceded
        self.rating = player_stats_summary.rating
        self.points = player_stats_summary.points
        self.clean_sheets = player_stats_summary.clean_sheets
        self.yellow_cards = player_stats_summary.yellow_cards
        self.red_cards = player_stats_summary.red_cards
        self.man_of_the_match = player_stats_summary.man_of_the_match
        self.shared_man_of_the_match = player_stats_summary.shared_man_of_the_match
        self.games_started = player_stats_summary.games_started
        self.games_substitute = player_stats_summary.games_substitute
        self.games_did_not_participate = player_stats_summary.games_did_not_participate
        self.points_per_appearance = player_stats_summary.points_per_appearance
        self.substitutions_on = player_stats_summary.substitutions_on
        self.substitutions_off = player_stats_summary.substitutions_off
        self.minutes_played = player_stats_summary.minutes_played
        self.ranking = player_stats_summary.ranking
    end
    
    def reset_stats_summary
        self.goals = 0
        self.goal_assists = 0
        self.own_goals = 0
        self.goals_conceded = 0
        self.rating = 0
        self.points = 0
        self.clean_sheets = 0
        self.yellow_cards = 0
        self.red_cards = 0
        self.man_of_the_match = 0
        self.shared_man_of_the_match = 0
        self.games_started = 0
        self.games_substitute = 0
        self.games_did_not_participate = 0
        self.points_per_appearance = 0
        self.substitutions_on = 0
        self.substitutions_off = 0
        self.minutes_played = 0              
    end
    
    private
      def init_stats_summary
        self.clean_sheets ||= 0
        self.yellow_cards ||= 0
        self.red_cards ||= 0
        self.man_of_the_match ||= 0
        self.shared_man_of_the_match ||= 0
        self.games_started ||= 0
        self.games_substitute ||= 0
        self.games_did_not_participate ||= 0
        self.points_per_appearance ||= 0
        self.substitutions_on ||= 0
        self.substitutions_off ||= 0
        self.minutes_played ||= 0
      end      
  end
  
end
