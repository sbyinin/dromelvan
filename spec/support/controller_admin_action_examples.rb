shared_examples_for "admin action controller" do |action|

  describe "'#{action}'" do
    context "as non-user" do
      specify do
        execute(action)
        expect(response).to be_not_found 
      end
    end
    
    context "as user" do
      let(:user) { FactoryGirl.create(:user) }
      
      before { sign_in user }
      
      specify do
        execute(action)
        expect(response).to be_not_found 
      end
    end

    context "as admin" do
      let(:admin) { FactoryGirl.create(:admin) }
      
      before { sign_in admin }
      
      specify do
        execute(action)
        expect(response).not_to be_not_found 
      end
    end    
  end

  def execute(action)
    if action == :new
      get action
    elsif action == :create
      post action, subject.controller_name.tableize.singularize.to_sym => FactoryGirl.attributes_for(subject.controller_name.tableize.singularize.to_sym)
    elsif action == :edit
      resource = FactoryGirl.create(subject.controller_name.tableize.singularize.to_sym)
      get action, id: resource.id      
    elsif action == :update
      resource = FactoryGirl.create(subject.controller_name.tableize.singularize.to_sym)
      patch action, id: resource.id, subject.controller_name.tableize.singularize.to_sym => FactoryGirl.attributes_for(subject.controller_name.tableize.singularize.to_sym)
    elsif action == :destroy
      resource = FactoryGirl.create(subject.controller_name.tableize.singularize.to_sym)
      delete action, id: resource.id
    end    
  end
end