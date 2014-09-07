require 'rails_helper'

describe SearchController, type: :controller do

  describe "GET 'search'" do
    specify do
      get :search, search: { q: 'search[q]' }
      expect(response).to be_success
    end
  end

  describe "GET 'live_search'" do
    specify do
      get :live_search, search: { q: 'search[q]' }, format: 'json'
      expect(response).to be_success
    end
  end
  
end
