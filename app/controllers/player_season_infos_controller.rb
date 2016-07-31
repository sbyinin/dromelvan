class PlayerSeasonInfosController < ApplicationController
  layout "modal", only: [ :edit ]
  
  def update
    player_season_info = PlayerSeasonInfo.find(params[:id])
    if player_season_info.update_attributes(resource_params)
      flash[:success] = "Player season information updated."
    else
      flash[:validation_errors] = player_season_info
    end    
    redirect_to player_season_info.player
  end
  
  private
    def resource_params
      @resource_params ||= params.require(:player_season_info).permit(:team_id, :d11_team_id, :value, :position_id)
      value = @resource_params[:value]
      if (Float(value) rescue false) or (Integer(value) rescue false) then
        @resource_params[:value] = (value.to_f * 10).to_int.to_s
      end      
      @resource_params
    end
  
end
