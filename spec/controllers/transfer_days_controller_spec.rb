require 'rails_helper'

describe TransferDaysController, type: :controller do

  it_should_behave_like "show controller"
  
  it_should_behave_like "select controller"
  
  it_should_behave_like "transfer_bids controller"
  
  it_should_behave_like "transfer_listings controller"

end
