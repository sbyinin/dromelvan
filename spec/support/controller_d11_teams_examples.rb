shared_examples_for "d11 teams controller" do

  describe "POST 'select_d11_teams'" do
    context "with existing resource" do
      specify do
        resource = FactoryGirl.create(subject.controller_name.tableize.singularize.to_sym)
        post :select_d11_teams, subject.controller_name.tableize.singularize.to_sym => { id: resource.id }
        expect(response).to redirect_to action: :show_d11_teams, id: resource.id
      end
    end

    context "with non-existing resource" do
      specify do
        post :select_d11_teams, subject.controller_name.tableize.singularize.to_sym => { id: -1 }
        expect(response).to be_not_found
      end
    end

  end

  describe "GET 'show_d11_teams'" do
    context "with no resource" do
      specify do
        get :show_d11_teams, id: -1
        expect(response).to be_not_found
      end
    end

    context "with existing resource" do
      specify do
        resource = FactoryGirl.create(subject.controller_name.tableize.singularize.to_sym)
        get :show_d11_teams, id: resource.id
        expect(response).to be_success
      end
    end
  end

end