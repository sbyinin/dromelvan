class TransferListingsDatatable
  include Datatable  

private

  def model_scope
    TransferListing.joins(:player)
        .joins(transfer_day: :transfer_window)
        .joins("join player_season_infos on player_season_infos.player_id = players.id and player_season_infos.season_id = transfer_windows.season_id")
        .joins("join teams on transfer_listings.team_id = teams.id")
        .joins("join positions on player_season_infos.position_id = positions.id")
  end
  
  def filter_columns 
    %w[players.first_name players.last_name teams.name positions.name d11_teams.name]
  end

  def sort_columns
    %w[players.last_name,players.first_name ranking teams.name positions.sort_order
       games_started,games_substitute points_per_appearance
       rating form_points points d11_teams.name d11_teams.code]
  end
  
  def data

    objects.map do |transfer_listing|
      season = transfer_listing.transfer_day.transfer_window.season
      player_season_info = PlayerSeasonInfo.where(player: transfer_listing.player, season: season).first
      team = transfer_listing.team
      d11_team = transfer_listing.d11_team      
      [
        render_partial('players/player', { player: transfer_listing.player }),
        transfer_listing.ranking,
        render_partial('teams/team', { team: team, label: :code }),
        render_partial('positions/position', { position: player_season_info.position, label: :code }),
        "#{transfer_listing.games_started}/#{transfer_listing.games_substitute}",
        transfer_listing.points_per_appearance_s,
        transfer_listing.rating_s,
        render_partial('players/player_form', { player: transfer_listing.player, season: season }),
        transfer_listing.points,
        render_partial('d11_teams/d11_team', { d11_team: d11_team }),
        render_partial('d11_teams/d11_team', { d11_team: d11_team, label: :code })
      ] 
    end
  end
  
  def filter_scope_params(scope_params)
    scope_params = { "transfer_listings.transfer_day_id" => scope_params[:transfer_day_id] }
  end
  
end