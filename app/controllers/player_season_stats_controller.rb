class PlayerSeasonStatsController < ApplicationController

  def ajax_params
    params.require(:ajax_params).permit(:season_id)
  end
  
end
