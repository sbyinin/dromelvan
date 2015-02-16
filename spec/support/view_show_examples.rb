shared_examples_for "show view" do |resource_class|  

  let(:resource) { FactoryGirl.create(resource_class.table_name.singularize.to_sym) }
  edit_route_exists = Rails.application.routes.routes.map{|route| route.defaults}.include?( { controller: resource_class.name.underscore.pluralize, action: 'edit' } )
  destroy_route_exists = Rails.application.routes.routes.map{|route| route.defaults}.include?( { controller: resource_class.name.underscore.pluralize, action: 'destroy' } )

  before do
    visit polymorphic_path(resource)
  end

  it { is_expected.to have_selector("div.#{resource.class.table_name.dasherize}.show##{resource.id}") }
  it { is_expected.to have_selector('h1', text: "#{h1_text}") }

  context "as non-user" do                          
    context "when edit route does not exist", if: !edit_route_exists do
      it { is_expected.not_to have_link('Edit', href: rails_admin.edit_path(model_name: resource.class.name, id: resource.id)) }        
    end
    
    context "when edit route exists", if: edit_route_exists do
      it { is_expected.not_to have_link('Edit', href: edit_polymorphic_path(resource)) }
      it { is_expected.not_to have_link('Edit', href: rails_admin.edit_path(model_name: resource.class.name, id: resource.id)) }        
    end
    
    context "when destroy route exists", if: destroy_route_exists do
      it { is_expected.not_to have_link('Delete', href: polymorphic_path(resource)) }
    end
  end
  
  context "as user" do
    let(:user) { FactoryGirl.create(:user) }
    
    before do
      sign_in user
      visit polymorphic_path(resource)
    end

    context "when edit route does not exist", if: !edit_route_exists do
      it { is_expected.not_to have_link('Edit', href: rails_admin.edit_path(model_name: resource.class.name, id: resource.id)) }        
    end
    
    context "when edit route exists", if: edit_route_exists do
      it { is_expected.not_to have_link('Edit', href: edit_polymorphic_path(resource)) }
      it { is_expected.not_to have_link('Edit', href: rails_admin.edit_path(model_name: resource.class.name, id: resource.id)) }        
    end
    
    context "when destroy route exists", if: destroy_route_exists do
      it { is_expected.not_to have_link('Delete', href: polymorphic_path(resource)) }
    end
  end

  context "as administrator" do
    let(:admin) { FactoryGirl.create(:admin) }    
    
    before do
      sign_in admin
      visit polymorphic_path(resource)
    end

    context "when edit route does not exist", if: !edit_route_exists do
      it { is_expected.to have_link('Edit', href: rails_admin.edit_path(model_name: resource.class.name, id: resource.id)) }
      
      context "after clicking edit" do     
        before do
          click_link 'Edit', href: rails_admin.edit_path(model_name: resource.class.name, id: resource.id)
        end
        
        it { is_expected.to have_selector("form#edit_#{resource_class.table_name.singularize}") }
      end      
    end
        
    context "when edit route exists", if: edit_route_exists do
      it { is_expected.to have_link('Edit', href: edit_polymorphic_path(resource)) }
      it { is_expected.not_to have_link('Edit', href: rails_admin.edit_path(model_name: resource.class.name, id: resource.id)) }

      context "after clicking edit" do     
        before do
          click_link 'Edit', href: edit_polymorphic_path(resource)
        end
        
        it { is_expected.to have_selector("form#edit_#{resource_class.table_name.singularize}_#{resource.id}") }
      end
    end
    
    context "when destroy route exists", if: destroy_route_exists do
      it { is_expected.to have_link('Delete', href: polymorphic_path(resource)) }
      
      specify { expect { click_link 'Delete', href: polymorphic_path(resource) }.to change(resource_class, :count).by(-1) }
      
      context "after clicking delete" do     
        before do
          click_link 'Delete', href: polymorphic_path(resource)
        end
        
        specify { expect{ resource.reload }.to raise_error(ActiveRecord::RecordNotFound) }
        
        it { is_expected.to have_selector("div.#{resource_class.table_name.dasherize}") } 
      end
    end
  end
end
