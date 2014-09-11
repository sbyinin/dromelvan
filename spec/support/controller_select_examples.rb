shared_examples_for "select controller" do

  describe "GET 'select'" do
    context "with existing resource" do
      specify do
        resource = FactoryGirl.create(subject.controller_name.tableize.singularize.to_sym)
        get :select, subject.controller_name.tableize.singularize.to_sym => {id: resource.id}
        expect(response).to redirect_to action: :show, id: resource.id
      end
    end
    
    context "with non-existing resource" do
      specify do
        get :select, subject.controller_name.tableize.singularize.to_sym => {id: -1}
        expect(response).to be_not_found
      end
    end    
  end
  
end