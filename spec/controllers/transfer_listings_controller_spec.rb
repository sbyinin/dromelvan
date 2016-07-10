require 'rails_helper'

describe TransferListingsController, type: :controller do

  # Testing the AJAX method
  describe "GET 'index'" do
    specify do
      transfer_day = FactoryGirl.create(:transfer_day)
      get :index, format: :json, ajax_params: {transfer_day_id: transfer_day.id}
      expect(response).to be_success
    end
  end
  
end
