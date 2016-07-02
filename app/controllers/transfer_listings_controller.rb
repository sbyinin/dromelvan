class TransferListingsController < ApplicationController

  def ajax_params
    params.require(:ajax_params).permit(:transfer_day_id)
  end
  
end
