shared_examples_for "league table controller" do

  describe "POST 'select_table'" do
    context "with existing resource" do
      specify do
        resource = FactoryGirl.create(subject.controller_name.tableize.singularize.to_sym)
        post :select_table, subject.controller_name.tableize.singularize.to_sym => { id: resource.id }
        expect(response).to redirect_to action: :show_table, id: resource.id
      end
    end

    context "with non-existing resource" do
      specify do
        post :select_table, subject.controller_name.tableize.singularize.to_sym => { id: -1 }
        expect(response).to be_not_found
      end
    end

  end

  describe "GET 'show_table'" do
    context "with no resource" do
      specify do
        get :show_table, id: -1
        expect(response).to be_not_found
      end
    end

    context "with existing resource" do
      specify do
        resource = FactoryGirl.create(subject.controller_name.tableize.singularize.to_sym)
        get :show_table, id: resource.id
        expect(response).to be_success
      end
    end
  end

end