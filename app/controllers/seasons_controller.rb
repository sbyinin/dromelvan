class SeasonsController < ApplicationController
  include Select

  def show
    redirect_to seasons_path
  end
  
end
