shared_examples_for "admin context menu" do |resource_class|
  let(:resource) { FactoryGirl.create(resource_class.table_name.singularize.to_sym) }
  
  context "as non-user" do
    before do
      visit polymorphic_path(resource)
    end

    it { is_expected.not_to within(:css, "div.context-menu.#{resource_class.table_name.singularize.dasherize}") { have_selector(selector[:css], text: selector[:text] ) } }
  end
  
  context "as user" do
    let(:user) { FactoryGirl.create(:user) }
    
    before do
      sign_in user
      visit polymorphic_path(resource)
    end

    it { is_expected.not_to within(:css, "div.context-menu.#{resource_class.table_name.singularize.dasherize}") { have_selector(selector[:css], text: selector[:text] ) } }
  end

  context "as admin" do
      let(:admin) { FactoryGirl.create(:admin) }
      
      before do
        sign_in admin
        visit polymorphic_path(resource)
      end
    
      it { is_expected.to within(:css, "div.context-menu.#{resource_class.table_name.singularize.dasherize}") { have_selector(selector[:css], text: selector[:text] ) } }
  end
  
end
