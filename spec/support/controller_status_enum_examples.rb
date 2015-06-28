shared_examples_for "status enum controller" do

  context "as non user" do
    describe "GET 'pend'" do
      specify do
        resource = FactoryGirl.create(subject.controller_name.tableize.singularize.to_sym)
        get :pend, id: resource.id
        expect(response).to be_not_found
      end      
    end
    
    describe "GET 'activate'" do
      specify do
        resource = FactoryGirl.create(subject.controller_name.tableize.singularize.to_sym)
        get :activate, id: resource.id
        expect(response).to be_not_found
      end      
    end
    
    describe "GET 'finish'" do
      specify do
        resource = FactoryGirl.create(subject.controller_name.tableize.singularize.to_sym)
        get :finish, id: resource.id
        expect(response).to be_not_found
      end      
    end    
  end

  context "as user" do    
    let(:user) { FactoryGirl.create(:user) }
    
    before { sign_in user }
    
    describe "GET 'pend'" do
      specify do
        resource = FactoryGirl.create(subject.controller_name.tableize.singularize.to_sym)
        get :pend, id: resource.id
        expect(response).to be_not_found
      end      
    end
    
    describe "GET 'activate'" do
      specify do
        resource = FactoryGirl.create(subject.controller_name.tableize.singularize.to_sym)
        get :activate, id: resource.id
        expect(response).to be_not_found
      end      
    end
    
    describe "GET 'finish'" do
      specify do
        resource = FactoryGirl.create(subject.controller_name.tableize.singularize.to_sym)
        get :finish, id: resource.id
        expect(response).to be_not_found
      end      
    end    
  end

  context "as admin" do    
    let(:admin) { FactoryGirl.create(:admin) }
    
    before { sign_in admin }
    
    describe "GET 'pend'" do
      context "with missing resource" do
        specify do
          get :pend, id: -1
          expect(response).to be_not_found
        end
      end

      context "with existing resource" do
        specify do
          resource = FactoryGirl.create(subject.controller_name.tableize.singularize.to_sym)
          get :pend, id: resource.id
          expect(response).to redirect_to resource
        end
      end
    end
    
    describe "GET 'activate'" do
      context "with missing resource" do
        specify do
          get :activate, id: -1
          expect(response).to be_not_found
        end
      end

      context "with existing resource" do      
        specify do
          resource = FactoryGirl.create(subject.controller_name.tableize.singularize.to_sym)
          get :activate, id: resource.id
          expect(response).to redirect_to resource
        end
      end
    end
    
    describe "GET 'finish'" do
      context "with missing resource" do
        specify do
          get :finish, id: -1
          expect(response).to be_not_found
        end
      end

      context "with existing resource" do        
        specify do
          resource = FactoryGirl.create(subject.controller_name.tableize.singularize.to_sym)
          get :finish, id: resource.id
          expect(response).to redirect_to resource
        end
      end
    end    
  end
  
end