class SearchController < ApplicationController

  def search    
    @q = search_params[:q]
    
    @players, @additional_player_count, @teams, @d11_teams = execute_search(@q)
  end

  def live_search    
    q = search_params[:q]

    players, additional_player_count, teams, d11_teams = execute_search(q)

    if additional_player_count > 0
      # Add a dummy player for the additional player count.
      players.push(Player.new(last_name: "... and #{additional_player_count} additional players"))
    end

    result = players + teams + d11_teams #+ stadia + users + seasons
    
    result_json = Jbuilder.encode do | json |    
      json.array! result do | object |
        json.name object.name
        json.path polymorphic_path(object)
        json.category object.class.name.titleize.pluralize
        # Not using the icon in the view at the moment but sending it back anyway for now.
        json.icon icon_url(object)
      end      
    end
    
    respond_to do |format|  
      format.html
      format.json { render json: result_json }
    end    
  end

private

  def search_params
    params.require(:search).permit(:q)
  end
  
  def execute_search(q)
    players = Player.named(q).order(first_name: :asc, last_name: :asc)
    additional_player_count = players.size - 20
    if additional_player_count > 0
      players = players[0..19]      
    end
    
    teams = Team.named(q)
    d11_teams = D11Team.named(q)    
    return players, additional_player_count, teams, d11_teams
  end
  
  def icon_url(object)
    if object.is_a?(Player)
      object.player_photo.url(:icon)
    else
      "None"
    end
  end    

end
