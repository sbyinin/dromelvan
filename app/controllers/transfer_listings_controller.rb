class TransferListingsController < ApplicationController

  def create
    player = Player.find(params[:player_id])
    player_season_info = player.season_info(Season.current)
    player_season_stat = player.season_stat(Season.current)
    transfer_day = TransferDay.current
    if player_season_info.nil? || player_season_stat.nil? || current_user.nil? || player_season_info.d11_team != current_user.active_d11_team || transfer_day.nil?
      not_found
    else
      if !player.transfer_listed?
	TransferListing.create(transfer_day: transfer_day, player: player, team: player_season_info.team, d11_team: player_season_info.d11_team,
			       position: player_season_info.position, goals: player_season_stat.goals, goal_assists: player_season_stat.goal_assists,
			       own_goals: player_season_stat.own_goals, goals_conceded: player_season_stat.goals_conceded, clean_sheets: player_season_stat.clean_sheets,
			       yellow_cards: player_season_stat.yellow_cards, red_cards: player_season_stat.red_cards, man_of_the_match: player_season_stat.man_of_the_match,
			       shared_man_of_the_match: player_season_stat.shared_man_of_the_match, rating: player_season_stat.rating, points: player_season_stat.points,
			       games_started: player_season_stat.games_started, games_substitute: player_season_stat.games_substitute,
			       games_did_not_participate: player_season_stat.games_did_not_participate, substitutions_on: player_season_stat.substitutions_on,
			       substitutions_off: player_season_stat.substitutions_off, minutes_played: player_season_stat.minutes_played,
			       ranking: player_season_stat.ranking, new_player: false, points_per_appearance: player_season_stat.points_per_appearance
			       )
	flash[:success] = "#{player.name} has been transfer listed. He will be removed from #{player_season_info.d11_team.name} if he's not removed from the transfer list before the transfer window opens."
      else
	flash[:danger] = "#{player.name} is already transfer listed."
      end
      redirect_to player_season_info.d11_team
    end
  end
  
  def destroy
    transfer_listing = TransferListing.find(params[:id])
    if !transfer_listing.transfer_day.pending? || current_user.nil? || transfer_listing.d11_team != current_user.active_d11_team
      not_found
    else
      player = transfer_listing.player
      d11_team = transfer_listing.d11_team
      transfer_listing.destroy
      flash[:success] = "#{player.name} has been removed from the transfer list."
      redirect_to d11_team
    end    
  end
    
  def ajax_params
    params.require(:ajax_params).permit(:transfer_day_id)
  end
  
end
