class PlayersController < ApplicationController
  include SelectSeason
  layout "modal", only: [ :new ]
  
  def new
    @player = Player.new
    if !params[:player].nil?
      @player.assign_attributes(resource_params)
    end
    @player_season_info = PlayerSeasonInfo.new
    if !params[:player_season_info].nil?
      @player_season_info.assign_attributes(player_season_info_params)
    end
  end

  def create
    super
    player_season_info = PlayerSeasonInfo.new(player: @player, season: Season.current)
    player_season_info.update_attributes(player_season_info_params)    
    PlayerSeasonStat.create(player: @player, season: Season.current)
    PlayerCareerStat.create(player: @player)    
  end
  
  def ajax_params
    params.permit(:country_id)
  end

  def resource_params
    params.require(:player).permit(:first_name, :last_name, :whoscored_id, :country_id)
  end
  
  def player_season_info_params
    params.require(:player_season_info).permit(:position_id, :team_id)
  end
end
