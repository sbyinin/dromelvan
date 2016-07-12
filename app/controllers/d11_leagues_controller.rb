class D11LeaguesController < ApplicationController
  include Select, LeagueTable, D11Teams

  def show
    d11_league = D11League.find(params[:id])
    redirect_to show_table_d11_league_path d11_league 
  end
  
end
