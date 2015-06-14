require 'rails_helper'

describe TeamTableStatsController, type: :controller do

  describe "GET 'index'" do
    specify do
      match_day = FactoryGirl.create(:match_day)
      get :index, format: :json, ajax_params: {match_day_id: match_day.id}
      expect(response).to be_success
    end
  end
  
end
