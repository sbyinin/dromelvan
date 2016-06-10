module SelectSeason
  extend ActiveSupport::Concern

  included do
    def show
      find_season
      super
    end
    
    def select_season
      show_season_url = url_for(controller: controller_name, action: 'show', season_id: select_season_params[:id])
      redirect_to show_season_url
    end
  end
  
  private
    def find_season
      season_id = show_params[:season_id]
      if season_id.nil?
        season_id = select_season_params[:id]
      end
      if season_id.blank?
        @season = Season.current
      else
        @season = Season.find(season_id)
      end
    end
    
    def show_params
      params.permit(:season_id)  
    end
    
    def select_season_params
      if !params[:season].nil?
        params.require(:season).permit(:id)
      else
        {}
      end
    end
  
end