require 'rails_helper'

describe PlayerSeasonStatsController, type: :controller do

  describe "GET 'index'" do
    specify do
      season = FactoryGirl.create(:season)
      get :index, format: :json, ajax_params: {season_id: season.id}
      expect(response).to be_success
    end
  end
  
end
