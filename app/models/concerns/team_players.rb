module TeamPlayers
  extend ActiveSupport::Concern
  
  included do
    def most_valuable_player(season)
      if !season.nil?
        PlayerSeasonStat.joins(player: :player_season_infos).where(player_season_infos: { "#{self.class.name.underscore}_id".to_sym => id, season_id: season.id }).where(season: season).uniq.order(:ranking).first
      else
        nil
      end    
    end
  
    def top_scorer(season)
      if !season.nil?
        PlayerSeasonStat.joins(player: :player_season_infos).where(player_season_infos: { "#{self.class.name.underscore}_id".to_sym => id, season_id: season.id }).where(season: season).uniq.order({goals: :desc}, :ranking).first
      else
        nil
      end
    end
  end
end


