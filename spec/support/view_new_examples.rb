shared_examples_for "new view" do |resource_class|  

  context "as administrator" do
    let(:admin) { FactoryGirl.create(:admin) }
    
    before do
      sign_in admin
      visit new_polymorphic_path(resource_class)
    end
  
    it { is_expected.to have_selector("form#new_#{resource_class.table_name.singularize}") }
    
    context "with invalid data" do
      specify { expect { click_button "Save" }.not_to change(resource_class, :count) }
      
      before { click_button "Save" }
      
      it { is_expected.to have_selector("form#new_#{resource_class.table_name.singularize}") }
      it { is_expected.to have_selector("div.alert") }
      it { is_expected.to have_selector("div.validation-errors") }
    end
    
    context "with valid data" do
      before do
        fill_in_form (defined?(selects) ? selects : {}), (defined?(fill_ins) ? fill_ins : {}), (defined?(checks) ? checks : {})       
      end

      specify { expect { click_button "Save" }.to change(resource_class, :count).by(1) }
      specify { expect { find('ul#main-menu').click_link "Home" }.not_to change(resource_class, :count) }
      
      context "after saving" do      
       
        before { click_button "Save" }
        
        let(:resource) { resource_class.all.reorder(created_at: :desc).first }
        it { is_expected.to have_selector("div.#{resource_class.table_name.dasherize}.show##{resource.id}") }
        
        let(:resource_attributes) { (defined?(selects) ? selects : {}).merge((defined?(fill_ins) ? fill_ins : {})).merge((defined?(checks) ? checks : {})) } 
        specify do
          resource_attributes.keys.each do |key|
            expect(resource[key.downcase.to_sym]).to eq resource_attributes[key]
          end            
        end
        
      end      
    end
  end
  
end
