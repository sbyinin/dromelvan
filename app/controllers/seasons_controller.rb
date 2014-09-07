class SeasonsController < ApplicationController

  private  
    def select_params
      params.require(:season).permit(:id)
    end
  
end
