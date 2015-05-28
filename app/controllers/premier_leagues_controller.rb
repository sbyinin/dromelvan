class PremierLeaguesController < ApplicationController
  include Select

  def table
    @premier_league = PremierLeague.find(params[:id])
  end
  
end
