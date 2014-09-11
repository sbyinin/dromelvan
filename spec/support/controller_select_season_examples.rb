shared_examples_for "select season controller" do

  describe "POST 'select_season'" do
    context "with existing season" do
      specify do
        resource = FactoryGirl.create(subject.controller_name.tableize.singularize.to_sym)
        season = FactoryGirl.create(:season)
        post :select_season, id: resource.id, season: {id: season.id}
        expect(response).to redirect_to action: :show, id: resource.id, season_id: season.id
      end
    end
    
    context "with non-existing season" do
      specify do
        resource = FactoryGirl.create(subject.controller_name.tableize.singularize.to_sym)
        post :select_season, id: resource.id, season: {id: -1}
        # The Season.find(-1) is done after the redirect so no not_found here.
        expect(response).to redirect_to action: :show, id: resource.id, season_id: -1
      end
    end    
  end

  describe "GET 'show'" do
    context "with no season" do
      specify do
        resource = FactoryGirl.create(subject.controller_name.tableize.singularize.to_sym)
        FactoryGirl.create(:season)
        get :show, id: resource.id
        expect(response).to be_success
      end
    end
    
    context "with existing season" do
      specify do
        resource = FactoryGirl.create(subject.controller_name.tableize.singularize.to_sym)
        season = FactoryGirl.create(:season)
        get :show, id: resource.id, season_id: season.id
        expect(response).to be_success
      end
    end
    
    context "with non-existing season" do
      specify do
        resource = FactoryGirl.create(subject.controller_name.tableize.singularize.to_sym)
        FactoryGirl.create(:season)
        get :show, id: resource.id, season_id: -1
        expect(response).to be_not_found
      end
    end    
  end
  
end