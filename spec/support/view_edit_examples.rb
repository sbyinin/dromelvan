shared_examples_for "edit view" do |resource_class|  

  context "as administrator" do
    let(:admin) { FactoryGirl.create(:admin) }
    let(:resource) { FactoryGirl.create(resource_class.name.underscore.to_sym) }
    let(:resource_attributes) { (defined?(selects) ? selects : {}).merge((defined?(fill_ins) ? fill_ins : {})).merge((defined?(checks) ? checks : {})) }
    
    before do
      sign_in admin
      visit edit_polymorphic_path(resource)
    end
   
    it { is_expected.to have_selector("form#edit_#{resource_class.table_name.singularize}_#{resource.id}") }

    context "with invalid data" do
      before do
        fill_ins.keys.each do |key|
          fill_in key, with: ""
        end
        click_button "Save Changes"        
      end
      
      it { is_expected.to have_selector("form#edit_#{resource_class.table_name.singularize}_#{resource.id}") }
      it { is_expected.to have_selector("div.alert") }
      it { is_expected.to have_selector("div.validation-errors") }
      
      specify do
        resource_attributes.keys.each do |key|
          expect(resource.reload[key.downcase.to_sym]).not_to eq resource_attributes[key]
        end            
      end      
    end

    context "with valid data" do
      before do
        fill_in_form (defined?(selects) ? selects : {}), (defined?(fill_ins) ? fill_ins : {}), (defined?(checks) ? checks : {})       
      end

      context "after cancelling" do        
        before { find('ul#main-menu').click_link "Home" }
        
        specify do
          resource_attributes.keys.each do |key|
            expect(resource.reload[key.downcase.to_sym]).not_to eq resource_attributes[key]
          end            
        end                
      end      
      
      context "after saving" do             
        before { click_button "Save Changes" }
        
        it { is_expected.to have_selector("div.#{resource_class.table_name.dasherize}.show##{resource.id}") }
        
        specify do
          resource_attributes.keys.each do |key|
            expect(resource.reload[key.downcase.to_sym]).to eq resource_attributes[key]
          end            
        end        
      end      
    end
  end
  
end
