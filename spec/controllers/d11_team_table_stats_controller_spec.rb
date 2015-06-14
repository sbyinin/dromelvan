require 'rails_helper'

describe D11TeamTableStatsController, type: :controller do

  describe "GET 'index'" do
    specify do
      d11_match_day = FactoryGirl.create(:d11_match_day)
      get :index, format: :json, ajax_params: {d11_match_day_id: d11_match_day.id}
      expect(response).to be_success
    end
  end
  
end
