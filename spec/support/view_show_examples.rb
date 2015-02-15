shared_examples_for "show view" do |resource_class|  

  let(:resource) { FactoryGirl.create(resource_class.table_name.singularize.to_sym) }

  before { visit polymorphic_path(resource) }

  it { is_expected.to have_selector("div.#{resource.class.table_name.dasherize}.show##{resource.id}") }
  it { is_expected.to have_selector('h1', text: "#{h1_text}") }
  it { is_expected.not_to have_link('Edit', href: rails_admin.edit_path(model_name: resource.class.name, id: resource.id) ) }

  context "as user" do
    let(:user) { FactoryGirl.create(:user) }
    
    before do
      sign_in user
      visit polymorphic_path(resource)
    end
    
    it { is_expected.not_to have_link('Edit', href: rails_admin.edit_path(model_name: resource.class.name, id: resource.id) ) }
  end

  context "as administrator" do
    let(:admin) { FactoryGirl.create(:admin) }
    
    before do
      sign_in admin
      visit polymorphic_path(resource)
    end
    
    it { is_expected.to have_link('Edit', href: rails_admin.edit_path(model_name: resource.class.name, id: resource.id) ) }
  end
end
