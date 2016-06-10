shared_examples_for "fixtures controller" do

  describe "POST 'select_fixtures'" do
    context "with existing resource" do
      specify do
        resource = FactoryGirl.create(subject.controller_name.tableize.singularize.to_sym)
        season = FactoryGirl.create(:season)
        post :select_fixtures, subject.controller_name.tableize.singularize.to_sym => { id: resource.id }
        expect(response).to redirect_to action: :show_fixtures, id: resource.id, season_id: season.id
      end
    end

    context "with non-existing resource" do
      specify do
        season = FactoryGirl.create(:season)
        post :select_fixtures, subject.controller_name.tableize.singularize.to_sym => { id: -1, season_id: season.id }
        expect(response).to be_not_found
      end
    end

  end

  describe "GET 'show_fixtures'" do
    context "with no resource" do
      specify do
        season = FactoryGirl.create(:season)
        get :show_fixtures, id: -1, season_id: season.id
        expect(response).to be_not_found
      end
    end

    context "with existing resource" do
      specify do
        resource = FactoryGirl.create(subject.controller_name.tableize.singularize.to_sym)
        season = FactoryGirl.create(:season)
        get :show_fixtures, id: resource.id, season_id: season.id
        expect(response).to be_success
      end
    end
  end

end