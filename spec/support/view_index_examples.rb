shared_examples_for "index view" do |resource_class|
  
  before do
    visit polymorphic_path(resource_class)
  end

  it { is_expected.to have_selector("div.#{resource_class.table_name.gsub('_','-')}") }

end