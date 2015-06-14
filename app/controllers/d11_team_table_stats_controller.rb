class D11TeamTableStatsController < ApplicationController

  def ajax_params
    params.require(:ajax_params).permit(:d11_match_day_id)
  end
  
end
