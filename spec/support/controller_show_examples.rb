shared_examples_for "show controller" do

  describe "GET 'show'" do
    context "with existing resource" do
      specify do
        resource = FactoryGirl.create(subject.controller_name.classify.downcase.to_sym)
        get :show, id: resource.id
        expect(response).to be_success
      end
    end
    
    context "with non-existing resource" do
      specify do
        get :show, id: -1
        expect(response).to be_not_found
      end
    end    
  end

end