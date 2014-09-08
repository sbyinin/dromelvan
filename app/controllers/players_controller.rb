class PlayersController < ApplicationController
  include SelectSeason
  
  def ajax_params
    params.permit(:country_id)
  end
  
end
