class PlayersController < ApplicationController
  include SelectSeason
  layout "modal", only: [ :new ]
  
  def create
    super
    PlayerSeasonStat.create(player: @player, season: Season.current)
    PlayerSeasonInfo.create(player: @player, season: Season.current)
  end
  
  def ajax_params
    params.permit(:country_id)
  end

  def resource_params
    params.require(:player).permit(:first_name, :last_name, :whoscored_id, :country_id)
  end
  
end
