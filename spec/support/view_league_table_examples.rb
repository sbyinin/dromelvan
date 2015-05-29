shared_examples_for "league table view" do |resource_class|

  let(:resource) { FactoryGirl.create(resource_class.table_name.singularize.to_sym) }

  before do
    visit public_send("show_table_#{resource.class.name.tableize.singularize}_path",resource)
  end

  it { is_expected.to have_selector("div.#{resource.class.table_name.dasherize}.show_table##{resource.id}") }
  it { is_expected.to have_selector('h1', text: "League table #{h1_text}") }

end
