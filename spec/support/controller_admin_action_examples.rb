shared_examples_for "admin action controller" do |action|

  describe "GET '#{action}'" do
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
    if action == :create || action == :update || action == :destroy
      post action, subject.controller_name.tableize.singularize.to_sym => FactoryGirl.attributes_for(subject.controller_name.tableize.singularize.to_sym)
    else
      get action
    end    
  end
end