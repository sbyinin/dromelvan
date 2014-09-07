class PlayersController < ApplicationController

  def ajax_params
    params.permit(:country_id)
  end
  
end
