class TeamTableStatsController < ApplicationController

  def ajax_params
    params.require(:ajax_params).permit(:match_day_id, :d11_match_day_id)
  end
  
end
