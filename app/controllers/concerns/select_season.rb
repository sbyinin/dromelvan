module SelectSeason
  extend ActiveSupport::Concern

  included do
    def show
      season_id = params[:season_id]
      if season_id.blank?
        @season = Season.current
      else
        @season = Season.find(season_id)
      end
      super
    end
    
    def select_season
      show_season_url = url_for(controller: controller_name, action: 'show', season_id: select_season_params[:id])
      redirect_to show_season_url
    end
  end
  
  private
    def select_season_params
      params.require(:season).permit(:id)
    end
  
end