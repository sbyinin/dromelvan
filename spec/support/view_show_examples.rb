shared_examples_for "show view" do |resource_class, selector|  

  let(:resource) { FactoryGirl.create(resource_class.table_name.singularize.to_sym) }
  edit_route_exists = Rails.application.routes.routes.map{|route| route.defaults}.include?( { controller: resource_class.name.underscore.pluralize, action: 'edit' } )

  before do
    visit polymorphic_path(resource)
    if resource.is_a?(Player)
      resource.player_season_infos.delete_all
      resource.player_season_stats.delete_all
      PlayerCareerStat.where(player: resource).delete_all          
    end
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
    
    it { is_expected.not_to have_link('Delete', href: rails_admin.delete_path(model_name: resource.class.name.tableize.singularize, id: resource.id)) }
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
    
    it { is_expected.not_to have_link('Delete', href: rails_admin.delete_path(model_name: resource.class.name.tableize.singularize, id: resource.id)) }
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

    it { is_expected.to have_link('Delete', href: rails_admin.delete_path(model_name: resource.class.name.tableize.singularize, id: resource.id)) }
    
    context "after clicking delete" do     
      before do
        click_link 'Delete', href: rails_admin.delete_path(model_name: resource.class.name.tableize.singularize, id: resource.id)
      end
      
      it { is_expected.to have_selector('h1', text: "Delete #{resource.class.name.tableize.singularize.humanize}") }
      
      context "after cancelling delete" do
        specify { expect { click_button 'Cancel' }.not_to change(resource_class, :count) }
      end
      
      context "after confirming delete" do
        specify { expect { click_button 'Yes, I\'m sure' }.to change(resource_class, :count).by(-1) }
        
        describe "resource should not exist" do
          before do
            click_button 'Yes, I\'m sure'
          end
          
          specify { expect{ resource.reload }.to raise_error(ActiveRecord::RecordNotFound) }
        end
      end
    end    
  end
end
