class TransferBidsController < ApplicationController
  layout "modal", only: [ :new, :edit ]
  
  def new
    transfer_day = TransferDay.current
    if transfer_day.nil? || !transfer_day.active?
      not_found
    else      
      @transfer_bid = TransferBid.new(fee: 0)
      if !params[:transfer_bid].nil?
	@transfer_bid.assign_attributes(resource_params)
	if @transfer_bid.player.nil? || !@transfer_bid.player.transfer_listed?
	  not_found
	end      
      else
	not_found
      end
    end
  end
  
  def create
    transfer_day = TransferDay.current
    if current_user.nil? || transfer_day.nil? || !transfer_day.active?
      not_found
    else
      transfer_bid = TransferBid.new(resource_params)
      player = transfer_bid.player
      if player.nil? || !player.transfer_listed?
	not_found
      else
	season = Season.current
	d11_team = current_user.active_d11_team	
	d11_team_table_stat = d11_team.d11_team_table_stats.where(d11_match_day: season.d11_league.current_d11_match_day).take
	d11_team_season_squad_stat = d11_team.d11_team_season_squad_stats.where(season: season).take
	if d11_team_table_stat.nil? || d11_team_season_squad_stat.nil? || transfer_day.transfer_bids.where(player: player, d11_team: d11_team).any? || !d11_team_season_squad_stat.position_available(player.season_info(season).position)
	  not_found
	else
	  player_season_stat = player.season_stat(season)
	  transfer_bid.transfer_day = transfer_day
	  transfer_bid.player_ranking = player_season_stat.ranking
	  transfer_bid.d11_team = d11_team
	  transfer_bid.d11_team_ranking = d11_team_table_stat.ranking
	  transfer_bid.active_fee = transfer_bid.fee
	  
	  if transfer_bid.valid? && transfer_bid.fee <= d11_team_season_squad_stat.max_bid
	    transfer_bid.save
	    redirect_to show_transfer_bids_transfer_day_path(transfer_day)
	  else
	    flash[:danger] = "#{transfer_bid.fee.to_f / 10.0} is an invalid fee. The fee must be greater than 0.0, less than your max bid #{d11_team_season_squad_stat.max_bid.to_f / 10.0} and divisible by 0.5."
	    redirect_to player
	  end	  
	end
      end      
    end    
  end
  
  def resource_params
    resource_params ||= params.require(:transfer_bid).permit(:player_id, :fee)
    fee = resource_params[:fee]
    if (Float(fee) rescue false) or (Integer(fee) rescue false) then
      resource_params[:fee] = (fee.to_f * 10).to_int.to_s
    end      
    resource_params
  end
    
end
