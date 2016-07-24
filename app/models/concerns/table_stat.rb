module TableStat
  extend ActiveSupport::Concern

  module ClassMethods
    def update_stats_from(match)
      home = match.read_association("home_([a-z0-9]*_)?team")
      away = match.read_association("away_([a-z0-9]*_)?team")
      date = match.read_association("([a-z0-9]*_)?match_day").date
      league = match.read_association("([a-z0-9]*_)?match_day").read_association("[a-z0-9]*_league")
      
      table_stats = date_ordered.where(home.class.name.underscore.to_sym => home, league.class.name.underscore.to_sym => league)    
      table_stats.each do |table_stat|
        if table_stat.date >= date
          table_stat.update_stats
          table_stat.save        
        end
      end
  
      table_stats = date_ordered.where(away.class.name.underscore.to_sym => away, league.class.name.underscore.to_sym => league)    
      table_stats.each do |table_stat|
        if table_stat.date >= date
          table_stat.update_stats
          table_stat.save        
        end
      end
    end    
    
    def update_rankings_from(match_day)
      match_day.class.reflections.keys.each do |key|
        if key.to_s.include?("_league")
          match_days = match_day.class.where("#{key.to_s}_id = ?", match_day.read_attribute("#{key.to_s}_id")).where("date >= ?", match_day.date)
          match_days.each do |current|
            update_rankings(current)          
          end
          match_days.each do |current|
            update_previous_rankings(current)
          end
          break
        end
      end
    end
    
    def update_rankings(match_day)
      ranking = 1
      combined_ordered.where("#{match_day.class.name.underscore}_id = ?",match_day.id).each do |table_stat|
        table_stat.ranking = ranking
        table_stat.save      
        ranking += 1
      end
      
      ranking = 1
      home_ordered.where("#{match_day.class.name.underscore}_id = ?",match_day.id).each do |table_stat|
        table_stat.home_ranking = ranking
        table_stat.save
        ranking += 1
      end
      
      ranking = 1
      away_ordered.where("#{match_day.class.name.underscore}_id = ?",match_day.id).each do |table_stat|
        table_stat.away_ranking = ranking
        table_stat.save
        ranking += 1
      end    
    end

    def update_previous_rankings(match_day)
      where("#{match_day.class.name.underscore}_id = ?",match_day.id).each do |table_stat|
        previous_table_stat = table_stat.previous
        if !previous_table_stat.nil?
          table_stat.previous_ranking = previous_table_stat.ranking
          table_stat.save
        end
      end
    end
  end
  
  included do
    default_scope -> { order(ranking: :asc) }
      
    after_initialize :init_table_stat
    before_validation :summarize_totals

    validates :matches_played, numericality: { greater_than_or_equal_to: 0 }
    validates :matches_won, numericality: { greater_than_or_equal_to: 0 }
    validates :matches_drawn, numericality: { greater_than_or_equal_to: 0 }
    validates :matches_lost, numericality: { greater_than_or_equal_to: 0 }
    validates :goals_for, numericality: { greater_than_or_equal_to: 0 }    
    validates :goals_against, numericality: { greater_than_or_equal_to: 0 }
    validates :goal_difference, presence: true, numericality: { only_integer: true }
    validates :points, numericality: { greater_than_or_equal_to: 0 }
    validates :form_points, numericality: { greater_than_or_equal_to: 0 }
    validates :ranking, presence: true, inclusion: 0..20
    validates :previous_ranking, presence: true, inclusion: 0..20
    validates :home_matches_played, numericality: { greater_than_or_equal_to: 0 }
    validates :home_matches_won, numericality: { greater_than_or_equal_to: 0 }
    validates :home_matches_drawn, numericality: { greater_than_or_equal_to: 0 }
    validates :home_matches_lost, numericality: { greater_than_or_equal_to: 0 }
    validates :home_goals_for, numericality: { greater_than_or_equal_to: 0 }    
    validates :home_goals_against, numericality: { greater_than_or_equal_to: 0 }
    validates :home_goal_difference, presence: true, numericality: { only_integer: true }
    validates :home_points, numericality: { greater_than_or_equal_to: 0 }
    validates :home_ranking, presence: true, inclusion: 0..20 
    validates :away_matches_played, numericality: { greater_than_or_equal_to: 0 }
    validates :away_matches_won, numericality: { greater_than_or_equal_to: 0 }
    validates :away_matches_drawn, numericality: { greater_than_or_equal_to: 0 }
    validates :away_matches_lost, numericality: { greater_than_or_equal_to: 0 }
    validates :away_goals_for, numericality: { greater_than_or_equal_to: 0 }    
    validates :away_goals_against, numericality: { greater_than_or_equal_to: 0 }
    validates :away_goal_difference, presence: true, numericality: { only_integer: true }
    validates :away_points, numericality: { greater_than_or_equal_to: 0 }
    validates :away_ranking, presence: true, inclusion: 0..20 
    validate :validate_totals
    
    def date
      read_association("([a-z0-9]*_)?match_day").date
    end

    def previous
      previous_match_day = read_association("([a-z0-9]*_)?match_day").previous
      if !previous_match_day.nil?
        my_team = read_association("([a-z0-9]*_)?team")
        self.class.where(my_team.class.name.underscore.to_sym => my_team, previous_match_day.class.name.underscore.to_sym => previous_match_day).first
      else
        nil
      end
    end

    def update_stats      
      my_team = read_association("([a-z0-9]*_)?team")
      my_match_day = read_association("([a-z0-9]*_)?match_day")
      match = my_match_day.read_association_class("([a-z0-9]*_)?matches")
                    .where("home_#{my_team.class.name.underscore}_id = ? or away_#{my_team.class.name.underscore}_id = ?", my_team.id, my_team.id)
                    .where(my_match_day.class.name.underscore.to_sym => my_match_day).first
      
      if match.finished?        
        goals_for = match.goals_for(my_team)
        goals_against = match.goals_against(my_team)
                    
        if match.read_association("([a-z0-9]*_)?team") == my_team   
          update_home_stats(goals_for, goals_against)
        else
          update_away_stats(goals_for, goals_against)        
        end
      else
        init_from_previous
      end    
    end
    
    private  
      def init_table_stat
        self.matches_played ||= 0
        self.matches_won ||= 0
        self.matches_drawn ||= 0
        self.matches_lost ||= 0
        self.goals_for ||= 0
        self.goals_against ||= 0
        self.goal_difference ||= 0
        self.points ||= 0
        self.form_points ||= 0
        self.ranking ||= 0
        self.previous_ranking ||= 0
        self.home_matches_played ||= 0
        self.home_matches_won ||= 0
        self.home_matches_drawn ||= 0
        self.home_matches_lost ||= 0
        self.home_goals_for ||= 0
        self.home_goals_against ||= 0
        self.home_goal_difference ||= 0
        self.home_points ||= 0
        self.home_ranking ||= 0
        self.away_matches_played ||= 0
        self.away_matches_won ||= 0
        self.away_matches_drawn ||= 0
        self.away_matches_lost ||= 0
        self.away_goals_for ||= 0
        self.away_goals_against ||= 0
        self.away_goal_difference ||= 0
        self.away_points ||= 0
        self.away_ranking ||= 0        
      end

      def init_from_previous
        previous_table_stat = previous

        self.home_goals_for = (previous_table_stat.nil? ? 0 : previous_table_stat.home_goals_for)
        self.home_goals_against = (previous_table_stat.nil? ? 0 : previous_table_stat.home_goals_against)
        self.home_matches_won = (previous_table_stat.nil? ? 0 : previous_table_stat.home_matches_won)
        self.home_matches_drawn = (previous_table_stat.nil? ? 0 : previous_table_stat.home_matches_drawn)
        self.home_matches_lost = (previous_table_stat.nil? ? 0 : previous_table_stat.home_matches_lost)     
        self.away_goals_for = (previous_table_stat.nil? ? 0 : previous_table_stat.away_goals_for)
        self.away_goals_against = (previous_table_stat.nil? ? 0 : previous_table_stat.away_goals_against)
        self.away_matches_won = (previous_table_stat.nil? ? 0 : previous_table_stat.away_matches_won)
        self.away_matches_drawn = (previous_table_stat.nil? ? 0 : previous_table_stat.away_matches_drawn)
        self.away_matches_lost = (previous_table_stat.nil? ? 0 : previous_table_stat.away_matches_lost)
        self.away_matches_lost = (previous_table_stat.nil? ? 0 : previous_table_stat.away_matches_lost)
      end
      
      def update_home_stats(goals_for, goals_against)
        init_from_previous
              
        self.home_goals_for += goals_for
        self.home_goals_against += goals_against
        
        if goals_for > goals_against then
          self.home_matches_won += 1
        elsif goals_for == goals_against then
          self.home_matches_drawn += 1
        else
          self.home_matches_lost += 1
        end
      end

      def update_away_stats(goals_for, goals_against)
        init_from_previous
        
        self.away_goals_for += goals_for
        self.away_goals_against += goals_against

        if goals_for > goals_against then
          self.away_matches_won += 1
        elsif goals_for == goals_against then
          self.away_matches_drawn += 1
        else
          self.away_matches_lost += 1
        end      
      end
      
      def summarize_totals
        init_table_stat # To get rid of errors that might arise from values being set to nil.

        self.home_matches_played = self.home_matches_won + self.home_matches_drawn + self.home_matches_lost
        self.home_goal_difference = self.home_goals_for - self.home_goals_against
        self.home_points = (self.home_matches_won * 3) + self.home_matches_drawn

        self.away_matches_played = self.away_matches_won + self.away_matches_drawn + self.away_matches_lost
        self.away_goal_difference = self.away_goals_for - self.away_goals_against
        self.away_points = (self.away_matches_won * 3) + self.away_matches_drawn

        self.matches_played = self.home_matches_played + self.away_matches_played
        self.matches_won = self.home_matches_won + self.away_matches_won
        self.matches_drawn = self.home_matches_drawn + self.away_matches_drawn
        self.matches_lost = self.home_matches_lost + self.away_matches_lost
        self.goals_for = self.home_goals_for + self.away_goals_for
        self.goals_against = self.home_goals_against + self.away_goals_against
        self.goal_difference = self.home_goal_difference + self.away_goal_difference
        self.points = self.home_points + self.away_points
        
        my_team = read_association("([a-z0-9]*_)?team")
        my_match_day = read_association("([a-z0-9]*_)?match_day")
        my_league = my_match_day.read_association("([a-z0-9]*_)?league")
        self.form_points = 0
        my_team.form_matches(my_match_day).each do |form_match|
          self.form_points += form_match.points(my_team)
        end
      end
      
      def validate_totals
        if self.home_matches_played != self.home_matches_won + self.home_matches_drawn + self.home_matches_lost
          errors.add(:home_matches_played, " has to be equal to home_matches_won + home_matches_drawn + home_matches_lost")
        end        
        if self.home_goal_difference != self.home_goals_for - self.home_goals_against
          errors.add(:home_goal_difference, " has to be equal to home_goals_for - home_goals_against")
        end
        if self.home_points != (self.home_matches_won * 3) + self.home_matches_drawn
          errors.add(:home_points, " has to be equal to (home_matches_won * 3) + home_matches_drawn")
        end
        
        if self.away_matches_played != self.away_matches_won + self.away_matches_drawn + self.away_matches_lost
          errors.add(:away_matches_played, " has to be equal to away_matches_won + away_matches_drawn + away_matches_lost")
        end        
        if self.away_goal_difference != self.away_goals_for - self.away_goals_against
          errors.add(:away_goal_difference, " has to be equal to away_goals_for - away_goals_against")
        end
        if self.away_points != (self.away_matches_won * 3) + self.away_matches_drawn
          errors.add(:away_points, " has to be equal to (away_matches_won * 3) + away_matches_drawn")
        end
        
        if self.matches_played != self.home_matches_played + self.away_matches_played
          errors.add(:matches_played, " has to be equal to home_matches_played + away_matches_played")
        end
        if self.matches_won != self.home_matches_won + self.away_matches_won
          errors.add(:matches_won, " has to be equal to home_matches_won + away_matches_won")
        end
        if self.matches_drawn != self.home_matches_drawn + self.away_matches_drawn
          errors.add(:matches_drawn, " has to be equal to home_matches_drawn + away_matches_drawn")
        end
        if self.matches_lost != self.home_matches_lost + self.away_matches_lost
          errors.add(:matches_lost, " has to be equal to home_matches_lost + away_matches_lost")
        end
        if self.goals_for != self.home_goals_for + self.away_goals_for
          errors.add(:goals_for, " has to be equal to home_goals_for + away_goals_for")
        end        
        if self.goals_against != self.home_goals_against + self.away_goals_against
          errors.add(:goals_against, " has to be equal to home_goals_against + away_goals_against")
        end
        if self.goal_difference != self.home_goal_difference + self.away_goal_difference
          errors.add(:goal_difference, " has to be equal to home_goal_difference + away_goal_difference")
        end
        if self.points != self.home_points + self.away_points
          errors.add(:points, " has to be equal to home_points + away_points")
        end
        
      end              
  end
  
end